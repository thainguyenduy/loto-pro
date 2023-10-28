import { IEventHandler } from '@nestjs/cqrs';
import { LotteryMBResultsCreatedEvent } from 'src/results/domain/events/LotteryMBResultsCreatedEvent';

export class LotteryMBResultsCreatedHandler
  implements IEventHandler<LotteryMBResultsCreatedEvent>
{
  handle(event: LotteryMBResultsCreatedEvent) {
    throw new Error('Method not implemented.');
  }
}
