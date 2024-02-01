import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity({ name: 'lottery_result' })
export class LotteryResultEntity {
  @PrimaryColumn({ type: 'uuid' })
  id: string;

  @Column({ unique: true })
  day: string;

  @Column('simple-array')
  giaiDacBiet: string[];

  @Column('simple-array')
  giaiNhat: string[];

  @Column('simple-array')
  giaiNhi: string[];

  @Column('simple-array')
  giaiBa: string[];

  @Column('simple-array')
  giaiTu: string[];

  @Column('simple-array')
  giaiNam: string[];

  @Column('simple-array')
  giaiSau: string[];

  @Column('simple-array')
  giaiBay: string[];

  constructor(options: LotteryResultEntity) {
    Object.assign(this, options);
  }
}
