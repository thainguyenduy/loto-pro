import { IAccount } from '../domain/Account';

export interface IAccountRepository {
  newId: () => Promise<string>;
  save: (account: IAccount | IAccount[]) => Promise<void>;
  findById: (id: number) => Promise<IAccount | null>;
  findByPhone: (phone: string) => Promise<IAccount[]>;
  updateDevice: (accountId: number, deviceId: string) => Promise<void>;
}
