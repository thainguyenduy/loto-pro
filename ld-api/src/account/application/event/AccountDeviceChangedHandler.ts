import { EventsHandler, IEventHandler } from '@nestjs/cqrs';
import { AccountDeviceChangedEvent } from 'src/account/domain/event/AccountDeviceChangedEvent';
import { AccountRepository } from 'src/account/infrastructure/repository/AccountRepository';
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
    await this.accountRepository.updateDevice(event.id, event.deviceId);
}
}
