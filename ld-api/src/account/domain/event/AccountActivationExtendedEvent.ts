import { IEvent } from '@nestjs/cqrs';
import { Phone } from 'libs/domain';

export class AccountActivationExtendedEvent implements IEvent {
  constructor(
    readonly id: string,
    readonly deviceId: string,
    readonly phone: Phone,
    readonly expirationDate: Date,
  ) {}
}
