import {
  Entity,
  GiaiDacBiet,
  GiaiNhat,
  GiaiNhi,
  GiaiBa,
  GiaiTu,
  GiaiNam,
  GiaiSau,
  GiaiBay,
  Day,
} from 'libs/domain';

export type LotteryResultProps = Readonly<
  Required<{
    day: Day;
    giaiDacBiet: GiaiDacBiet;
    giaiNhat: GiaiNhat;
    giaiNhi: GiaiNhi;
    giaiBa: GiaiBa;
    giaiTu: GiaiTu;
    giaiNam: GiaiNam;
    giaiSau: GiaiSau;
    giaiBay: GiaiBay;
  }>
>;

export interface ILotteryResult {
  readonly day: Day;
  readonly giaiDacBiet: GiaiDacBiet;
  readonly giaiNhat: GiaiNhat;
  readonly giaiNhi: GiaiNhi;
  readonly giaiBa: GiaiBa;
  readonly giaiTu: GiaiTu;
  readonly giaiNam: GiaiNam;
  readonly giaiSau: GiaiSau;
  readonly giaiBay: GiaiBay;
  compare: (result: ILotteryResult) => boolean;
  toPlainObject: () => object;
  // create: (options: LotteryResultProps) => ILotteryResult;
}

export class LotteryResult
  extends Entity<LotteryResultProps>
  implements ILotteryResult
{
  readonly day: Day;
  readonly giaiDacBiet: GiaiDacBiet;
  readonly giaiNhat: GiaiNhat;
  readonly giaiNhi: GiaiNhi;
  readonly giaiBa: GiaiBa;
  readonly giaiTu: GiaiTu;
  readonly giaiNam: GiaiNam;
  readonly giaiSau: GiaiSau;
  readonly giaiBay: GiaiBay;
  constructor(options: LotteryResultProps) {
    super(options);
  }
  public compare(result: ILotteryResult): boolean {
    return (
      this.day.equals(result.day) &&
      this.giaiDacBiet.equals(result.giaiDacBiet) &&
      this.giaiNhat.equals(result.giaiNhat) &&
      this.giaiNhi.equals(result.giaiNhi) &&
      this.giaiBa.equals(result.giaiBa) &&
      this.giaiTu.equals(result.giaiTu) &&
      this.giaiNam.equals(result.giaiNam) &&
      this.giaiSau.equals(result.giaiSau) &&
      this.giaiBay.equals(result.giaiBay)
    );
  }
  toPlainObject(): object {
    return {
      id: this.Id,
      giaiDacBiet: this.giaiDacBiet.value,
      giaiNhat: this.giaiNhat.value,
      giaiNhi: this.giaiNhi.value,
      giaiBa: this.giaiBa.value,
      giaiTu: this.giaiTu.value,
      giaiNam: this.giaiNam.value,
      giaiSau: this.giaiSau.value,
      giaiBay: this.giaiBay.value,
      day: this.day.value,
    };
  }
}
