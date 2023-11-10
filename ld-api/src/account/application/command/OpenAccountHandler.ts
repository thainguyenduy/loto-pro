import { Inject } from '@nestjs/common';
import { CommandHandler, ICommandHandler } from '@nestjs/cqrs';

import { Transactional } from '../../../../libs/Transactional';

import { OpenAccountCommand } from './OpenAccountCommand';
import { InjectionToken } from '../InjectionToken';

import { AccountFactory } from '../../domain/AccountFactory';
import { IAccountRepository } from '../IAccountRepository';
import { Password, Phone } from '../../../../libs/domain';

@CommandHandler(OpenAccountCommand)
export class OpenAccountHandler
  implements ICommandHandler<OpenAccountCommand, void>
{
  @Inject(InjectionToken.ACCOUNT_REPOSITORY)
  private readonly accountRepository: IAccountRepository;
  @Inject() private readonly accountFactory: AccountFactory;

  @Transactional()
  async execute(command: OpenAccountCommand): Promise<void> {
    const account = this.accountFactory.create({
      ...command,
      id: await this.accountRepository.newId(),
      password: Password.create({ value: command.password, hashed: false }),
      phone: Phone.create({ value: command.phone }),
      deviceId: command.deviceId,
    });

    account.open();

    await this.accountRepository.save(account);

    account.commit();
  }
}
