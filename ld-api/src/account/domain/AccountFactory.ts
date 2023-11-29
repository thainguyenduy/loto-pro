import { Inject } from '@nestjs/common';
import { EventPublisher } from '@nestjs/cqrs';

import { IAccount, AccountProps, Account } from './Account';
import { Password, Phone } from 'libs/domain';
import { Device } from './Device';

type CreateAccountOptions = Readonly<{
  phone: Phone;
  password: Password;
  deviceId: string;
}>;

type CreateDeviceOptions = Readonly<{
  deviceId: string;
  active: boolean;
  accountId: number;
}>;

export class AccountFactory {
  @Inject(EventPublisher) private readonly eventPublisher: EventPublisher;

  create(
    options: CreateAccountOptions,
    deviceOptions: CreateDeviceOptions,
  ): IAccount {
    return this.eventPublisher.mergeObjectContext(
      Account.create({
        ...options,
        id: null,
        activated: false,
        expirationDate: null,
        lockedAt: null,
        createdAt: new Date(),
        updatedAt: new Date(),
        devices: Device.create({
          ...deviceOptions,
          active: true,
          deviceId: options.deviceId,
          accountId: null,
          id: null,
          createdAt: new Date(),
          updatedAt: new Date(),
          lockedAt: null,
        }),
      }),
    );
  }

  reconstitute(properties: AccountProps): IAccount {
    return this.eventPublisher.mergeObjectContext(Account.create(properties));
  }
}
