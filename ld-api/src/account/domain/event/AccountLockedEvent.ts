import { IEvent } from '@nestjs/cqrs';
import { Phone } from 'libs/domain';

export class AccountLockedEvent implements IEvent {
  constructor(
    readonly id: string,
    readonly phone: Phone,
  ) {}
}
