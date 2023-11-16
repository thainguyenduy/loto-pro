import { Day } from 'libs/domain';
import { ILotteryResult } from '../domain/LotteryResult';
import { IParserContentStrategy } from '../infrastructure/LotteryResultService';

export interface ILotteryResultService {
  parser: IParserContentStrategy;
  getLotteryResult: (day: Day) => Promise<ILotteryResult>;
}
