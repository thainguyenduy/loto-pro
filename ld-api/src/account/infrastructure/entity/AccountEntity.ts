import { Entity, Column, OneToMany, PrimaryGeneratedColumn } from 'typeorm';

import { BaseEntity } from 'libs/infrastructure/typeorm/BaseEntity';
import { DeviceEntity } from './DeviceEntity';

@Entity({ name: 'account' })
export class AccountEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 10, unique: true })
  phone: string;

  @Column()
  activated: boolean;

  @Column()
  deviceId: string;

  @Column()
  password: string;

  @Column({ type: 'datetime', precision: 6, nullable: true })
  lockedAt: Date | null;

  @Column({ type: 'datetime', precision: 6, nullable: true })
  expirationDate: Date | null;

  @OneToMany(() => DeviceEntity, (device) => device.account, { eager: true })
  devices: DeviceEntity[];
  constructor(options: AccountEntity) {
    super();
    Object.assign(this, options);
  }
}
