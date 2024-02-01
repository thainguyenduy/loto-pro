import { ICommand } from '@nestjs/cqrs';
import { Day } from 'libs/domain';

export class GetLotteryResultCommand implements ICommand {
  constructor(readonly day: Day) {}
}
