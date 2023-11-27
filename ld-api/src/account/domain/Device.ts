import { Entity } from 'libs/domain';
import { Account } from './Account';

export type DeviceEssentialProps = Readonly<
  Required<{
    deviceId: string;
    active: boolean;
    accountId: number;
  }>
>;

export type DeviceOptionalProps = Readonly<
  Partial<{
    id: number;
    createdAt: Date;
    updatedAt: Date;
    lockedAt: Date | null;
  }>
>;

export type DeviceProps = DeviceEssentialProps & Required<DeviceOptionalProps>;

export interface IDevice {
  Id: number;
  getActive: boolean;
  getDeviceId: string;
  getCreatedAt: Date;
  getUpdatedAt: Date;
  getLockedAt: Date;
  getAccountId: number;
}

export class Device extends Entity<DeviceProps> implements IDevice {
  private readonly createdAt: Date;
  private readonly updatedAt: Date;
  public active: boolean;
  private lockedAt: Date | null;
  private accountId: number;
  private deviceId: string;
  // public account: Account;

  private constructor(props: DeviceProps) {
    super(props);
  }

  public static create(props: DeviceProps) {
    return new Device(props);
  }

  get getDeviceId() {
    return this.deviceId;
  }

  get getActive(): boolean {
    return this.active;
  }

  get getAccountId() {
    return this.accountId;
  }

  get getCreatedAt() {
    return this.createdAt;
  }

  get getUpdatedAt() {
    return this.updatedAt;
  }

  get getLockedAt() {
    return this.lockedAt;
  }
}
