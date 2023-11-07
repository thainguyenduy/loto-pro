import { Inject, NotFoundException } from '@nestjs/common';
import { CommandHandler, ICommandHandler } from '@nestjs/cqrs';

import { Transactional } from '../../../../libs/Transactional';

import { LockAccountCommand } from '../../application/command/LockAccountCommand';
import { InjectionToken } from '../../application/InjectionToken';
import { IAccount } from '../../domain/Account';
import { IAccountRepository } from '../IAccountRepository';

@CommandHandler(LockAccountCommand)
export class LockAccountHandler
  implements ICommandHandler<LockAccountCommand, void>
{
  @Inject(InjectionToken.ACCOUNT_REPOSITORY)
  private readonly accountRepository: IAccountRepository;

  @Transactional()
  async execute(command: LockAccountCommand): Promise<void> {
    const account: IAccount = await this.accountRepository.findById(
      command.accountId,
    );
    if (!account) throw new NotFoundException('Account is not found');

    account.lock();

    await this.accountRepository.save(account);

    account.commit();
  }
}
