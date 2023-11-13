import { Entity, Column, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';

import { BaseEntity } from 'libs/infrastructure/typeorm/BaseEntity';
import { AccountEntity } from './AccountEntity';

@Entity({ name: 'device' })
export class DeviceEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  deviceId: string;

  @Column()
  accountId: number;

  @Column({ type: 'datetime', precision: 6, nullable: true })
  lockedAt: Date | null;

  @ManyToOne(() => AccountEntity, (account) => account.devices)
  account: AccountEntity;

  constructor(options: DeviceEntity) {
    super();
    Object.assign(this, options);
  }
}
