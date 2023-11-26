import { FindAccountsQuery } from './FindAccountsQuery';
import { FindAccountByIdResult } from './FindAccountByIdResult';
import { FindAccountsResult } from './FindAccountsResult';
import { DeviceEntity } from 'src/account/infrastructure/entity/DeviceEntity';

export interface IAccountQuery {
  findById: (id: number) => Promise<FindAccountByIdResult | null>;
  findByPhone: (query: FindAccountsQuery) => Promise<FindAccountsResult>;
  findOneByPhone: (phone: string) => Promise<{
    activated: boolean;
    devices: DeviceEntity[];
    accountId: number;
    phone: string;
    deviceId: string;
    password: string;
  } | null>;
}
