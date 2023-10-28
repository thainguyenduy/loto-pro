import { Entity } from 'src/core/domain/entities/Entity';
import { Day } from 'src/core/domain/value-objects/Day';
import { LotteryMBResults } from 'src/lottery/domain/LotteryMBResults';

export type BetProps = Readonly<
  Required<{
    id: string;
    accountId: string;
    contactId: string;
    day: Day;
    predict: number;
    amount: number; //Tiền đặt cược
    rate: number;
  }>
>;

export interface IBet {
  getAccountId: string;
  getContactId: string;
  calculate: (result: LotteryMBResults) => number;
}

abstract class Bet extends Entity<BetProps> implements IBet {
  abstract calculate(result: LotteryMBResults);
  protected readonly accountId: string;
  protected readonly contactId: string;
  protected readonly day: Day;
  protected readonly predict: number;
  protected readonly amount: number; //Tiền đặt cược
  protected readonly rate: number;
  public get getAccountId(): string {
    return this.accountId;
  }
  public get getContactId(): string {
    return this.contactId;
  }
}
export class BetLo extends Bet {
  calculate(result: LotteryMBResults): number {
    let counter: number = 0;
    if (result.giaiDacBiet == this.predict) counter++;
    if (result.giaiNhat1 == this.predict) counter++;
    if (result.giaiNhi1 == this.predict) counter++;
    if (result.giaiNhi2 == this.predict) counter++;

    return counter ? counter * this.rate * this.amount : 0;
  }
}
export class BetDe extends Bet {
  calculate(result: LotteryMBResults): number {
    if (result.giaiDacBiet != this.predict) return 0;
    return this.amount * this.rate;
  }
}
