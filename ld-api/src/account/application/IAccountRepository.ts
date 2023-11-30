import { IAccount } from '../domain/Account';

export interface IAccountRepository {
  save: (account: IAccount | IAccount[]) => Promise<IAccount[]>;
  findById: (id: string) => Promise<IAccount | null>;
  updateDevice: (accountId: string, deviceId: string) => Promise<void>;
}
