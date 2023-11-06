import addYears from 'date-fns/addYears';
import { LessThan } from 'typeorm';
import { Cron, CronExpression } from '@nestjs/schedule';
import { Inject, Logger, Module, Provider } from '@nestjs/common';
import { CqrsModule } from '@nestjs/cqrs';

import { PasswordModule } from 'libs/PasswordModule';
import {
  EntityIdTransformer,
  ENTITY_ID_TRANSFORMER,
  writeConnection,
} from 'libs/DatabaseModule';

import { AccountQuery } from 'src/account/infrastructure/query/AccountQuery';
import { AccountRepository } from 'src/account/infrastructure/repository/AccountRepository';
import { AccountEntity } from 'src/account/infrastructure/entity/AccountEntity';

import { AccountsController } from 'src/account/interface/AccountsController';
import { AccountTaskController } from 'src/account/interface/AccountTaskController';

import { CloseAccountHandler } from 'src/account/application/command/CloseAccountHandler';
import { OpenAccountHandler } from 'src/account/application/command/OpenAccountHandler';

import { UpdatePasswordHandler } from 'src/account/application/command/UpdatePasswordHandler';

import { FindAccountByIdHandler } from 'src/account/application/query/FindAccountByIdHandler';
import { FindAccountsHandler } from 'src/account/application/query/FindAccountsHandler';
import { InjectionToken } from 'src/account/application/InjectionToken';
import { AccountOpenedHandler } from 'src/account/application/event/AccountOpenedHandler';

import { PasswordUpdatedHandler } from 'src/account/application/event/PasswordUpdatedHandler';
import { AccountClosedHandler } from 'src/account/application/event/AccountClosedHandler';

import { AccountDomainService } from 'src/account/domain/AccountDomainService';
import { AccountFactory } from 'src/account/domain/AccountFactory';

const infrastructure: Provider[] = [
  {
    provide: InjectionToken.ACCOUNT_REPOSITORY,
    useClass: AccountRepository,
  },
  {
    provide: InjectionToken.ACCOUNT_QUERY,
    useClass: AccountQuery,
  },
];

const application = [
  CloseAccountHandler,
  OpenAccountHandler,
  UpdatePasswordHandler,
  FindAccountByIdHandler,
  FindAccountsHandler,
  AccountOpenedHandler,
  LockAccountHandler,
  PasswordUpdatedHandler,
  AccountClosedHandler,
];

const domain = [AccountDomainService, AccountFactory];

@Module({
  imports: [CqrsModule, PasswordModule],
  controllers: [AccountsController, AccountTaskController],
  providers: [Logger, ...infrastructure, ...application, ...domain],
})
export class AccountsModule {
  @Inject(ENTITY_ID_TRANSFORMER)
  private readonly entityIdTransformer: EntityIdTransformer;

  @Cron(CronExpression.EVERY_DAY_AT_MIDNIGHT)
  async lockExpiredAccount(): Promise<void> {
    (
      await writeConnection.manager
        .getRepository(AccountEntity)
        .findBy({ expirationDate: LessThan(new Date()) })
    ).forEach(
      (account) =>
        new LockAccountCommand(this.entityIdTransformer.from(account.id)),
    );
  }
}
