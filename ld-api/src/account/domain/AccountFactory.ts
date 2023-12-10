import { Inject } from '@nestjs/common';
import { EventPublisher } from '@nestjs/cqrs';

import { IAccount, AccountProps, Account } from './Account';
import { Id, Password, Phone } from 'libs/domain';
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
    const aId = Id.create();

    return this.eventPublisher.mergeObjectContext(
      new Account({
        ...options,
        id: aId,
        devices: [
          /* this.deviceFactory.create({
            accountId: aId,
            deviceId: options.deviceId,
            active: false,
          }), */
        ],
      }),
    ) as IAccount;
  }

  reconstitute(properties: AccountProps): IAccount {
    return this.eventPublisher.mergeObjectContext(
      new Account(properties),
    ) as IAccount;
  }
}
