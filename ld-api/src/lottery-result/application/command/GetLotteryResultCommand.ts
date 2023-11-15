import { ICommand } from '@nestjs/cqrs';

export class GetLotteryResultCommand implements ICommand {
  constructor() {}
}
