import { Entity } from 'src/core/domain/entities/Entity';
import { DebtAmountChangedEvent } from '../application/events/DebtAmountChangedEvent';
export type DebtProps = Readonly<
  Required<{
    accountId: string;
    contactId: string;
  }>
> & { amount: number };

export interface IDebt {
  change: (amount: number) => void;
}
export class Debt extends Entity<DebtProps> implements IDebt {
  private readonly accountId: string;
  private readonly contactId: string;
  private amount: number;
  change(amount: number) {
    this.amount += amount;
    this.apply(new DebtAmountChangedEvent(this.accountId, amount));
  }
}
