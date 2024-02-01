import { IQuery } from '@nestjs/cqrs';

export class GetLotteryResultByDayQuery implements IQuery {
  constructor(readonly day: string) {}
}
