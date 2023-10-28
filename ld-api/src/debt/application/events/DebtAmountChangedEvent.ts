export class DebtAmountChangedEvent {
  constructor(
    public readonly accountId: string,
    public readonly amount: number,
  ) {}
}
