import { EventsHandler, IEventHandler } from '@nestjs/cqrs';
import { AccountLoggedInEvent } from 'src/account/domain/event/AccountLoggedInEvent';
import { IAccountRepository } from '../IAccountRepository';
import { Inject } from '@nestjs/common';
import { InjectionToken } from '../InjectionToken';

@EventsHandler(AccountLoggedInEvent)
export class AccountLoggedInEventHandler
  implements IEventHandler<AccountLoggedInEvent>
{
  constructor(
    @Inject(InjectionToken.ACCOUNT_REPOSITORY)
    private readonly accountRepository: IAccountRepository,
  ) {}

  async handle(event: AccountLoggedInEvent) {
    /* neu co deviceId roi thi cap nhat updatedAt, neu chua thi insert */
    await this.accountRepository.updateDevice(event.id.value, event.deviceId);
  }
}
