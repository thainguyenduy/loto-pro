import { IEvent } from '@nestjs/cqrs';
import { Phone } from '../../../../libs/domain';

export class AccountDeviceChangedEvent implements IEvent {
  constructor(
    readonly accountId: string,
    readonly deviceId: string,
    readonly phone: Phone,
  ) {}
}
