import { UnprocessableEntityException } from '@nestjs/common';
import { Entity, Password, Phone } from 'libs/domain';
import { AccountDeviceChangedEvent } from './event/AccountDeviceChangedEvent';
import { AccountActivationExtendedEvent } from './event/AccountActivationExtendedEvent';
import { PasswordUpdatedEvent } from './event/PasswordUpdatedEvent';
import { AccountLockedEvent } from './event/AccountLockedEvent';
import { AccountOpenedEvent } from './event/AccountOpenedEvent';

export type AccountEssentialProps = Readonly<
  Required<{
    id: string;
    phone: Phone;
    password: Password;
    deviceId: string; //https://stackoverflow.com/questions/45031499/how-to-get-unique-device-id-in-flutter
  }>
>;

export type AccountOptionalProps = Readonly<
  Partial<{
    activated: boolean;
    expirationDate: Date;
    createdAt: Date;
    updatedAt: Date;
    lockedAt: Date | null;
  }>
>;

export type AccountProps = AccountEssentialProps &
  Required<AccountOptionalProps>;

export interface IAccount {
  Id: string;
  isActivated: boolean;
  getDeviceId: string;
  getPhone: string;
  getExpirationDate: Date;
  getHashedPassword: Promise<string>;
  getCreatedAt: Date;
  getUpdatedAt: Date;
  getLockedAt: Date;
  open: () => void;
  active: (expiration_date: Date) => void;
  updatePassword: (password: string) => void;
  lock: () => void;
  changeDevice: (device_id: string) => void;
  commit: () => void;
}

export class Account extends Entity<AccountProps> implements IAccount {
  private readonly phone: Phone;
  private readonly createdAt: Date;
  private activated: boolean;
  private expirationDate: Date;
  private password: Password;
  private lockedAt: Date | null;
  private updatedAt: Date;
  private deviceId: string;

  constructor(props: AccountProps) {
    super(props);
  }

  get getPhone() {
    return this.phone.value;
  }

  get getExpirationDate() {
    return this.expirationDate;
  }

  get getHashedPassword() {
    return this.password.getHashedValue();
  }

  get getCreatedAt() {
    return this.createdAt;
  }

  get getUpdatedAt() {
    return this.createdAt;
  }

  get getLockedAt() {
    return this.lockedAt;
  }

  get getDeviceId() {
    return this.deviceId;
  }

  get isActivated(): boolean {
    return this.activated;
  }

  open(): void {
    this.apply(new AccountOpenedEvent(this.id, this.phone.value));
  }
  changeDevice(device_id: string): void {
    this.deviceId = device_id;
    this.apply(
      new AccountDeviceChangedEvent(this.id, this.deviceId, this.phone.value),
    );
  }

  active(expiration_date: Date): void {
    this.activated = true;
    this.expirationDate = expiration_date;
    this.apply(
      new AccountActivationExtendedEvent(
        this.id,
        this.deviceId,
        this.phone,
        this.expirationDate,
      ),
    );
  }

  updatePassword(password: string): void {
    this.password = Password.create({ value: password, hashed: true });
    this.updatedAt = new Date();
    this.apply(new PasswordUpdatedEvent(this.id, this.phone));
  }

  lock(): void {
    if (this.lockedAt)
      throw new UnprocessableEntityException('Account is already locked');
    this.activated = false;
    this.lockedAt = new Date();
    this.updatedAt = new Date();
    this.apply(new AccountLockedEvent(this.id, this.phone));
  }
}
