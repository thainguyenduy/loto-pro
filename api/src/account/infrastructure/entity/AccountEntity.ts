import { Entity, Column, OneToMany } from 'typeorm';

import { BaseEntity } from 'libs/infrastructure/typeorm/BaseEntity';
import { DeviceEntity } from './DeviceEntity';

@Entity({ name: 'account' })
export class AccountEntity extends BaseEntity {
  @Column({ length: 10, unique: true })
  phone: string;

  @Column()
  activated: boolean;

  @Column({ nullable: true })
  deviceId: string;

  @Column()
  password: string;

  @Column({ type: 'datetime', precision: 6, nullable: true })
  lockedAt: Date | null;

  @Column({ type: 'datetime', precision: 6, nullable: true })
  expirationDate: Date | null;

  @OneToMany(() => DeviceEntity, (device) => device.account, {
    eager: true,
    cascade: ['insert', 'update'],
  })
  devices: DeviceEntity[];
  constructor(options: AccountEntity) {
    super();
    Object.assign(this, options);
  }
}
