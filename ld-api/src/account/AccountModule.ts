import { LessThan } from 'typeorm';
import { Cron, CronExpression } from '@nestjs/schedule';
import { Inject, Logger, Module, Provider } from '@nestjs/common';
import { CommandBus, CqrsModule } from '@nestjs/cqrs';

import {
  EntityIdTransformer,
  ENTITY_ID_TRANSFORMER,
  writeConnection,
} from 'libs/DatabaseModule';

import { AccountQuery } from 'src/account/infrastructure/query/AccountQuery';
import { AccountRepository } from 'src/account/infrastructure/repository/AccountRepository';
import { AccountEntity } from 'src/account/infrastructure/entity/AccountEntity';

import { AccountsController } from 'src/account/interface/AccountsController';

import { OpenAccountHandler } from 'src/account/application/command/OpenAccountHandler';

import { UpdatePasswordHandler } from 'src/account/application/command/UpdatePasswordHandler';

import { FindAccountByIdHandler } from 'src/account/application/query/FindAccountByIdHandler';
import { FindAccountsHandler } from 'src/account/application/query/FindAccountsHandler';
import { InjectionToken } from 'src/account/application/InjectionToken';

import { AccountFactory } from 'src/account/domain/AccountFactory';
import { LockAccountCommand } from './application/command/LockAccountCommand';
import { LockAccountHandler } from './application/command/LockAccountHandler';
import { JwtModule, JwtService } from '@nestjs/jwt';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { LoginAccountHandler } from './application/query/LoginAccountHandler';
import { AccountDeviceChangedHandler } from './application/event/AccountDeviceChangedHandler';
import { AuthGuard } from 'libs/Auth';

const infrastructure: Provider[] = [
  {
    provide: InjectionToken.ACCOUNT_REPOSITORY,
    useClass: AccountRepository,
  },
  {
    provide: InjectionToken.ACCOUNT_QUERY,
    useClass: AccountQuery,
  },
  ConfigService,
  JwtService,
  AuthGuard,
];

const application = [
  OpenAccountHandler,
  UpdatePasswordHandler,
  FindAccountByIdHandler,
  FindAccountsHandler,
  LockAccountHandler,
  LoginAccountHandler,
  AccountDeviceChangedHandler,
];

const domain = [AccountFactory];

@Module({
  imports: [
    CqrsModule,
    JwtModule.registerAsync({
      imports: [ConfigModule],
      global: true,
      useFactory: async (configService: ConfigService) => ({
        secretOrPrivateKey: configService.get<string>('SECRET_KEY'),
        signOptions: {
          expiresIn: 3600,
        },
      }),
      inject: [ConfigService],
    }),
  ],
  controllers: [AccountsController],
  providers: [Logger, ...infrastructure, ...application, ...domain],
})
export class AccountsModule {
  @Inject(ENTITY_ID_TRANSFORMER)
  private readonly entityIdTransformer: EntityIdTransformer;
  @Inject() private commandBus: CommandBus;

  @Cron(CronExpression.EVERY_DAY_AT_MIDNIGHT)
  async lockExpiredAccount(): Promise<void> {
    (
      await writeConnection.manager
        .getRepository(AccountEntity)
        .findBy({ expirationDate: LessThan(new Date()) })
    ).forEach((account) =>
      this.commandBus.execute(
        new LockAccountCommand(this.entityIdTransformer.from(account.id)),
      ),
    );
  }
}
