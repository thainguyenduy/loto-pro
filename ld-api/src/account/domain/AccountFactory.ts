import { Inject } from '@nestjs/common';
import { EventPublisher } from '@nestjs/cqrs';

import { IAccount, AccountProps, Account } from './Account';
import { Password, Phone } from 'libs/domain';

type CreateAccountOptions = Readonly<{
  phone: Phone;
  password: Password;
  deviceId: string;
}>;

export class AccountFactory {
  @Inject(EventPublisher) private readonly eventPublisher: EventPublisher;

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
      }),
    );
  }

  reconstitute(properties: AccountProps): IAccount {
    return this.eventPublisher.mergeObjectContext(Account.create(properties));
  }
}
