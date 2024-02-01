import { IEvent } from '@nestjs/cqrs';
import { Id, Phone } from '../../../../libs/domain';
export class AccountActivationExtendedEvent implements IEvent {
  constructor(
    readonly id: Id,
    readonly deviceId: string,
    readonly phone: Phone,
    readonly expirationDate: Date,
  ) {}
}
