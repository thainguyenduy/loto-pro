import { ILotteryResult } from '../domain/LotteryResult';

export interface ILotteryResultService {
  getLotteryResult: (day: string) => Promise<ILotteryResult>;
}
