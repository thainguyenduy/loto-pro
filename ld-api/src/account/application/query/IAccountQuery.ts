import { FindAccountsQuery } from './FindAccountsQuery';
import { FindAccountByIdResult } from './FindAccountByIdResult';
import { FindAccountsResult } from './FindAccountsResult';

export interface IAccountQuery {
  findById: (id: string) => Promise<FindAccountByIdResult | null>;
  findByPhone: (query: FindAccountsQuery) => Promise<FindAccountsResult>;
}
