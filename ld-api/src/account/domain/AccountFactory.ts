import { Inject } from '@nestjs/common';
import { EventPublisher } from '@nestjs/cqrs';

import { IAccount, AccountProps, Account } from 'src/account/domain/Account';
import { Password } from 'src/core/domain/value-objects/Password';

type CreateAccountOptions = Readonly<{
  id: string;
  imei: string;
  password: Password;
}>;

export class AccountFactory {
  @Inject(EventPublisher) private readonly eventPublisher: EventPublisher;

  create(options: CreateAccountOptions): IAccount {
    return this.eventPublisher.mergeObjectContext(
      new Account({
        ...options,
        contacts: [],
        lockedAt: null,
        createdAt: new Date(),
        updatedAt: new Date(),
        deletedAt: null,
        version: 0,
      }),
    );
  }

  reconstitute(properties: AccountProps): IAccount {
    return this.eventPublisher.mergeObjectContext(new Account(properties));
  }
}
