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
} from 'libs/domain';

export type LotteryResultProps = Readonly<
  Required<{
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
  compare: (result: LotteryResult) => boolean;
  // create: (options: LotteryResultProps) => ILotteryResult;
}

export class LotteryResult
  extends Entity<LotteryResultProps>
  implements ILotteryResult
{
  private readonly giaiDacBiet: GiaiDacBiet;
  private readonly giaiNhat: GiaiNhat;
  private readonly giaiNhi: GiaiNhi;
  private readonly giaiBa: GiaiBa;
  private readonly giaiTu: GiaiTu;
  private readonly giaiNam: GiaiNam;
  private readonly giaiSau: GiaiSau;
  private readonly giaiBay: GiaiBay;
  private constructor(options: LotteryResultProps) {
    super(options);
  }
  public compare(result: LotteryResult): boolean {
    return (
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
  public static create(options: LotteryResultProps): ILotteryResult {
    return new LotteryResult(options);
  }
}
