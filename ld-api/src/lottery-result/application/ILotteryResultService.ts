import { Day } from 'libs/domain';
import { ILotteryResult } from '../domain/LotteryResult';
import { IParserResultStrategy } from '../infrastructure/service/LotteryResultService';

export interface ILotteryResultService {
  parser: IParserResultStrategy;
  getLotteryResult: (day: Day) => Promise<ILotteryResult>;
}
