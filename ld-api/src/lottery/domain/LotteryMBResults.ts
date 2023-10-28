import { AggregateRoot } from '@nestjs/cqrs';
import { LotteryMBResultsCreatedEvent } from './events/LotteryMBResultsCreatedEvent';
import { Day } from 'src/shared/domain/value-objects/Day';
export type LotteryMBResultsProperties = Readonly<
  Required<{
    giaiDacBiet: number;
    giaiNhat1: number;
    giaiNhi1: number;
    giaiNhi2: number;
  }>
>;

export class LotteryMBResults extends AggregateRoot {
  public readonly day: Day;
  public readonly giaiDacBiet: number;
  public readonly giaiNhat1: number;
  public readonly giaiNhi1: number;
  public readonly giaiNhi2: number;

  constructor(properties: LotteryMBResultsProperties) {
    super();
    Object.assign(this, properties);
    this.apply(new LotteryMBResultsCreatedEvent());
  }
}
