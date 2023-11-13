import { Inject } from '@nestjs/common';
import { CommandHandler, EventBus, ICommandHandler } from '@nestjs/cqrs';

import { Transactional } from '../../../../libs/Transactional';

import { OpenAccountCommand } from './OpenAccountCommand';
import { InjectionToken } from '../InjectionToken';

import { AccountFactory } from '../../domain/AccountFactory';
import { IAccountRepository } from '../IAccountRepository';
import { Password, Phone } from '../../../../libs/domain';
import { AccountDeviceChangedEvent } from 'src/account/domain/event/AccountDeviceChangedEvent';

@CommandHandler(OpenAccountCommand)
export class OpenAccountHandler
  implements ICommandHandler<OpenAccountCommand, void>
{
  @Inject() private readonly eventBus: EventBus;
  @Inject(InjectionToken.ACCOUNT_REPOSITORY)
  private readonly accountRepository: IAccountRepository;
  @Inject() private readonly accountFactory: AccountFactory;

  @Transactional()
  async execute(command: OpenAccountCommand): Promise<void> {
    const account = this.accountFactory.create({
      ...command,
      password: Password.create({ value: command.password }),
      phone: Phone.create({ value: command.phone }),
      deviceId: command.deviceId,
    });

    account.open();

    const accounts = await this.accountRepository.save(account);
    if (accounts.length > 0)
      this.eventBus.publish(
        new AccountDeviceChangedEvent(
          accounts[0].Id,
          command.deviceId,
          Phone.create({ value: command.phone }),
        ),
      );

    account.commit();
  }
}
