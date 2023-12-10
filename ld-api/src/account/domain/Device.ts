import { Exclude, Expose, instanceToPlain } from 'class-transformer';
import { Entity, Id } from 'libs/domain';

export type DeviceEssentialProps = Readonly<
  Required<{
    id: Id;
    deviceId: string;
    active: boolean;
  }>
>;

export type DeviceOptionalProps = Readonly<
  Partial<{
    accountId: Id;
    createdAt: Date;
    updatedAt: Date;
    lockedAt: Date | null;
  }>
>;

export type DeviceProps = DeviceEssentialProps & DeviceOptionalProps;

export interface IDevice {
  isA: (device_id: string) => boolean;
  activate: () => void;
  deactivate: () => void;
  toPlainObject: () => object;
  changeAccount: (account_id: Id) => void;
}

@Exclude()
export class Device extends Entity<DeviceProps> implements IDevice {
  changeAccount: (account_id: Id) => void;
  @Expose() private readonly deviceId: string;
  @Expose() private active: boolean;
  @Expose() private readonly createdAt: Date = new Date();
  @Expose() private updatedAt: Date = new Date();
  @Expose() private lockedAt?: Date;
  @Expose() private accountId: Id;
  // public account: Account;
  public isA(device_id: string): boolean {
    return this.deviceId == device_id;
  }
  activate(): void {
    this.active = true;
  }
  deactivate(): void {
    this.active = false;
  }
  toPlainObject() {
    return {
      ...instanceToPlain(this),
      id: this.Id.value,
      accountId: this.accountId.value,
    };
  }
}
