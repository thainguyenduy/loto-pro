import { Inject, NotFoundException } from '@nestjs/common';
import { CommandHandler, ICommandHandler } from '@nestjs/cqrs';

import { Transactional } from '../../../../libs/Transactional';

import { InjectionToken } from '../InjectionToken';
import { IAccount } from '../../domain/Account';
import { IAccountRepository } from '../IAccountRepository';
import { SignOutAccountCommand } from './SignOutAccountCommand';

@CommandHandler(SignOutAccountCommand)
export class SignOutAccountCommandHandler
  implements ICommandHandler<SignOutAccountCommand, void>
{
  @Inject(InjectionToken.ACCOUNT_REPOSITORY)
  private readonly accountRepository: IAccountRepository;

  @Transactional()
  async execute(command: SignOutAccountCommand): Promise<void> {
    const account: IAccount = await this.accountRepository.findById(
      command.accountId,
    );
    if (!account) throw new NotFoundException('Account is not found');

    // account.signOutDevice();

    await this.accountRepository.save(account);

    account.commit();
  }
}
