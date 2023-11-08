import { FindAccountsQuery } from './FindAccountsQuery';
import { FindAccountByIdResult } from './FindAccountByIdResult';
import { FindAccountsResult } from './FindAccountsResult';
import { LoginAccountResult } from './LoginAccountResult';
import { LoginAccountQuery } from './LoginAccountQuery';

export interface IAccountQuery {
  findById: (id: string) => Promise<FindAccountByIdResult | null>;
  findByPhone: (query: FindAccountsQuery) => Promise<FindAccountsResult>;
  findOneByPhone: (query: LoginAccountQuery) => Promise<LoginAccountResult | null>;
}
