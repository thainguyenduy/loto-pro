import { IQuery } from '@nestjs/cqrs';

export class FindAccountsQuery implements IQuery {
  readonly phone: string;
  readonly skip: number;
  readonly take: number;

  constructor(options: FindAccountsQuery) {
    Object.assign(this, options);
  }
}
