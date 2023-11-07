import { Inject, NotFoundException } from '@nestjs/common';
import { CommandHandler, ICommandHandler } from '@nestjs/cqrs';

import { Transactional } from '../../../../libs/Transactional';

import { UpdatePasswordCommand } from './UpdatePasswordCommand';
import { InjectionToken } from '../InjectionToken';

import { ErrorMessage } from '../../domain/ErrorMessage';
import { IAccountRepository } from '../IAccountRepository';

@CommandHandler(UpdatePasswordCommand)
export class UpdatePasswordHandler
  implements ICommandHandler<UpdatePasswordCommand, void>
{
  @Inject(InjectionToken.ACCOUNT_REPOSITORY)
  private readonly accountRepository: IAccountRepository;

  @Transactional()
  async execute(command: UpdatePasswordCommand): Promise<void> {
    const account = await this.accountRepository.findById(command.accountId);
    if (!account)
      throw new NotFoundException(ErrorMessage.ACCOUNT_IS_NOT_FOUND);

    account.updatePassword(command.password);

    await this.accountRepository.save(account);

    account.commit();
  }
}
