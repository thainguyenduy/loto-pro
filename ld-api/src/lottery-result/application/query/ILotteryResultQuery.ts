import { LotteryResultEntity } from 'src/lottery-result/infrastructure/entity/LotteryResultEntity';

export interface ILotteryResultQuery {
  findByDay: (day: string) => Promise<LotteryResultEntity | null>;
}
