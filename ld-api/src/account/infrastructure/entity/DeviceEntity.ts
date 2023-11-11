import {
  Entity,
  Column,
  ManyToOne,
  PrimaryColumn,
  PrimaryGeneratedColumn,
} from 'typeorm';

import { BaseEntity } from 'libs/infrastructure/typeorm/BaseEntity';
import { AccountEntity } from './AccountEntity';

@Entity({ name: 'device' })
export class DeviceEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  id: string;

  @Column()
  accountId: string;

  @Column({ type: 'datetime', precision: 6, nullable: true })
  lockedAt: Date | null;

  @ManyToOne(() => AccountEntity, (account) => account.devices)
  account: AccountEntity;

  constructor(options: DeviceEntity) {
    super();
    Object.assign(this, options);
  }
}
