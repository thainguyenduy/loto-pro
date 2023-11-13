import { FindAccountsQuery } from './FindAccountsQuery';
import { FindAccountByIdResult } from './FindAccountByIdResult';
import { FindAccountsResult } from './FindAccountsResult';

export interface IAccountQuery {
  findById: (id: number) => Promise<FindAccountByIdResult | null>;
  findByPhone: (query: FindAccountsQuery) => Promise<FindAccountsResult>;
  findOneByPhone: (phone: string) => Promise<{
    accountId: number;
    phone: string;
    deviceId: string;
    password: string;
  } | null>;
}
