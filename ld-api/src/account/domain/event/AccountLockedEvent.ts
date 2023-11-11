import { IEvent } from '@nestjs/cqrs';
import { Phone } from 'libs/domain';

export class AccountLockedEvent implements IEvent {
  constructor(
    readonly id: number,
    readonly phone: Phone,
  ) {}
}
