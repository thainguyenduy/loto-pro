import { Entity, Column, PrimaryColumn } from 'typeorm';

import { BaseEntity } from 'libs/infrastructure/typeorm/BaseEntity';

@Entity()
export class AccountEntity extends BaseEntity {
  @PrimaryColumn({ type: 'binary', length: 16 })
  id: Buffer;

  @Column({ length: 10 })
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

  constructor(options: AccountEntity) {
    super();
    Object.assign(this, options);
  }
}
