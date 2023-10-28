import { Inject } from '@nestjs/common';
import { EventPublisher } from '@nestjs/cqrs';
import { BetLo, BetProps, IBet } from './Bet';
export type BET_TYPE = 'LO' | 'DE' | 'XIEN' | 'BA_CANG';

export class BetFactory {
  @Inject(EventPublisher) private readonly eventPublisher: EventPublisher;

  create(options: BetProps & { betType: BET_TYPE }): IBet {
    switch (options.betType) {
      case 'LO':
        return this.eventPublisher.mergeObjectContext(new BetLo(options));
      case 'DE':
      case 'XIEN':
      case 'BA_CANG':
        break;
    }
  }
}
