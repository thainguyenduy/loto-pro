import { EventsHandler, IEventHandler } from '@nestjs/cqrs';
import { AccountDeviceChangedEvent } from 'src/account/domain/event/AccountDeviceChangedEvent';
import { IAccountRepository } from '../IAccountRepository';
import { Inject } from '@nestjs/common';
import { InjectionToken } from '../InjectionToken';

@EventsHandler(AccountDeviceChangedEvent)
export class AccountDeviceChangedHandler
  implements IEventHandler<AccountDeviceChangedEvent>
{
  constructor(
    @Inject(InjectionToken.ACCOUNT_REPOSITORY)
    private readonly accountRepository: IAccountRepository,
  ) {}

  async handle(event: AccountDeviceChangedEvent) {
    /* neu co deviceId roi thi cap nhat updatedAt, neu chua thi insert */
    await this.accountRepository.updateDevice(event.id, event.deviceId);
  }
}
