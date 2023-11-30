import { Inject } from '@nestjs/common';
import { EventPublisher } from '@nestjs/cqrs';
import {
  ILotteryResult,
  LotteryResult,
  LotteryResultProps,
} from './LotteryResult';

export class LotteryResultFactory {
  @Inject(EventPublisher) private readonly eventPublisher: EventPublisher;

  create(options: LotteryResultProps): ILotteryResult {
    return this.eventPublisher.mergeObjectContext(new LotteryResult(options));
  }
  reconstitute(
    properties: LotteryResultProps & { id: string },
  ): ILotteryResult {
    return this.eventPublisher.mergeObjectContext(
      new LotteryResult(properties),
    );
  }
}
