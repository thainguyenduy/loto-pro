import { Day } from 'libs/domain';
import { ILotteryResult } from './domain/LotteryResult';

export interface ILotteryResultRepository {
  save: (lotteryResult: ILotteryResult) => Promise<ILotteryResult>;
  findResultByDay: (day: Day) => Promise<ILotteryResult | null>;
}
