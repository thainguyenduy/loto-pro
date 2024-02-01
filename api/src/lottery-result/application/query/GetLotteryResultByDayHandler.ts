import { IQueryHandler, QueryHandler } from '@nestjs/cqrs';
import { GetLotteryResultByDayQuery } from './GetLotteryResultByDayQuery';
import { GetLotteryResultByDayResult } from './GetLotteryResultByDayResult';
import { InjectionToken } from '../InjectionToken';
import { ILotteryResultQuery } from './ILotteryResultQuery';
import { Inject, NotFoundException } from '@nestjs/common';
import { plainToInstance } from 'class-transformer';
import { InfraErrorMessage } from 'src/lottery-result/infrastructure/InfraErrorMessage';

@QueryHandler(GetLotteryResultByDayQuery)
export class GetLotteryResultByDayHandler
  implements
    IQueryHandler<GetLotteryResultByDayQuery, GetLotteryResultByDayResult>
{
  @Inject(InjectionToken.LOTTERY_RESULT_QUERY)
  readonly lotteryResultQuery: ILotteryResultQuery;

  async execute(
    query: GetLotteryResultByDayQuery,
  ): Promise<GetLotteryResultByDayResult> {
    const data = await this.lotteryResultQuery.findByDay(query.day);
    if (!data)
      throw new NotFoundException(
        InfraErrorMessage.LOTTERY_RESULT_BY_DAY_NOT_FOUND,
      );

    const result = plainToInstance(GetLotteryResultByDayResult, data);
    return result;
  }
}
