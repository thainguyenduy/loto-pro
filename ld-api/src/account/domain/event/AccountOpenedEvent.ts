import { IEvent } from '@nestjs/cqrs';
import { Id, Phone } from '../../../../libs/domain';
export class AccountOpenedEvent implements IEvent {
  constructor(
    readonly id: Id,
    readonly phone: Phone,
    readonly deviceId: string,
  ) {}
}
