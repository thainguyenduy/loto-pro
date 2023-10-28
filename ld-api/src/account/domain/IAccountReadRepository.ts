import { Account } from 'src/account/domain/Account';

export interface IAccountReadRepository {
  findById: (id: string) => Promise<Account | null>;
  findByName: (name: string) => Promise<Account[]>;
}
