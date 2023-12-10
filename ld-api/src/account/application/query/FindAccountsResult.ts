import { IQueryResult } from '@nestjs/cqrs';

export class FindAccountsResult implements IQueryResult {
  constructor(
    readonly accounts: Readonly<{
      id: string;
      phone: string;
      expirationDate: Date;
      activated: boolean;
    }>[],
  ) {}
}
