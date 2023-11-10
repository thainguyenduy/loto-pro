import { IEvent } from '@nestjs/cqrs';
import { Phone } from '../../../../libs/domain';
export class AccountOpenedEvent implements IEvent {
  constructor(
    readonly accountId: string,
    readonly phone: Phone,
    readonly deviceId: string,
  ) {}
}
