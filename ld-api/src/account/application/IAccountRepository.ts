import { IAccount } from '../domain/Account';

export interface IAccountRepository {
  save: (account: IAccount | IAccount[]) => Promise<IAccount[]>;
  findById: (id: number) => Promise<IAccount | null>;
  updateDevice: (accountId: number, deviceId: string) => Promise<void>;
}
