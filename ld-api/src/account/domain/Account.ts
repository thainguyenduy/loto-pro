import { UnprocessableEntityException } from '@nestjs/common';
import { Entity, Id, Password, Phone } from '../../../libs/domain';
import { AccountLoggedInEvent } from './event/AccountLoggedInEvent';
import { AccountActivationExtendedEvent } from './event/AccountActivationExtendedEvent';
import { PasswordUpdatedEvent } from './event/PasswordUpdatedEvent';
import { AccountLockedEvent } from './event/AccountLockedEvent';
import { AccountOpenedEvent } from './event/AccountOpenedEvent';
import { IDevice } from './Device';
import { instanceToPlain } from 'class-transformer';

export type AccountEssentialProps = Readonly<
  Required<{
    id: Id;
    phone: Phone;
    password: Password;
    deviceId: string; //https://stackoverflow.com/questions/45031499/how-to-get-unique-device-id-in-flutter
  }>
>;

/* TODO: Refactor partial type: no need to provide 
values for all fields when using factory create */
export type AccountOptionalProps = Readonly<
  Partial<{
    activated: boolean;
    expirationDate: Date;
    createdAt: Date;
    updatedAt: Date;
    lockedAt: Date | null;
    devices: IDevice[];
  }>
>;

export type AccountProps = AccountEssentialProps & AccountOptionalProps;

export interface IAccount {
  open: () => void;
  active: (expiration_date: Date) => void;
  updatePassword: (password: string) => void;
  lock: () => void;
  changeDevice: (device_id: string) => void;
  commit: () => void;
  signOutDevice: () => void;
  toPlainObject: () => Promise<object>;
}

export class Account extends Entity<AccountProps> implements IAccount {
  private readonly phone: Phone;
  private password: Password;
  private deviceId: string;
  private activated: boolean = true;
  private expirationDate?: Date;
  private readonly createdAt: Date = new Date();
  private updatedAt: Date = new Date();
  private lockedAt: Date | null;
  // khi dang nhap thanh cong thi cap nhat con` khi dang xuat thi xoa'
  private devices: IDevice[];

  open(): void {
    this.apply(new AccountOpenedEvent(this.Id, this.phone, this.deviceId));
  }
  changeDevice(device_id: string): void {
    this.deviceId = device_id;
    this.apply(new AccountLoggedInEvent(this.Id, this.deviceId, this.phone));
  }

  active(expiration_date: Date): void {
    this.activated = true;
    this.expirationDate = expiration_date;
    this.apply(
      new AccountActivationExtendedEvent(
        this.Id,
        this.deviceId,
        this.phone,
        this.expirationDate,
      ),
    );
  }

  updatePassword(password: string): void {
    this.password = Password.create({ value: password, hashed: false });
    this.updatedAt = new Date();
    this.apply(new PasswordUpdatedEvent(this.Id, this.phone));
  }

  lock(): void {
    if (this.lockedAt)
      throw new UnprocessableEntityException('Account is already locked');
    this.activated = false;
    this.lockedAt = new Date();
    this.updatedAt = new Date();
    this.apply(new AccountLockedEvent(this.Id, this.phone));
  }
  signOutDevice(): void {
    const i = this.devices.findIndex((e) => e.isA(this.deviceId));
    this.devices[i].deactivate();
    this.deviceId = null;
  }
  async toPlainObject(): Promise<object> {
    return {
      ...instanceToPlain(this),
      password: await this.password.getHashedValue(),
      devices: await Promise.all(
        this.devices.map(async (device) => await device.toPlainObject()),
      ),
    };
  }
}
