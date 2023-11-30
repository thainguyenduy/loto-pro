import { Inject } from '@nestjs/common';
import { EventPublisher } from '@nestjs/cqrs';

import { IAccount, AccountProps, Account } from './Account';
import { Password, Phone } from 'libs/domain';
import { Device } from './Device';
import { DeviceFactory } from './DeviceFactory';

type CreateAccountOptions = Readonly<{
  phone: Phone;
  password: Password;
  deviceId: string;
}>;

export class AccountFactory {
  @Inject(EventPublisher) private readonly eventPublisher: EventPublisher;
  @Inject() private readonly deviceFactory: DeviceFactory;
  create(options: CreateAccountOptions): IAccount {
    return this.eventPublisher.mergeObjectContext(
      Account.create({
        ...options,
        id: null,
        activated: false,
        expirationDate: null,
        lockedAt: null,
        createdAt: new Date(),
        updatedAt: new Date(),
        devices: [
          this.deviceFactory.create({
            deviceId: options.deviceId,
            active: true,
          }) as Device,
        ],
      }),
    );
  }

  reconstitute(properties: AccountProps): IAccount {
    return this.eventPublisher.mergeObjectContext(Account.create(properties));
  }
}
