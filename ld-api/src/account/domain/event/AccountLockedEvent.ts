import { IEvent } from '@nestjs/cqrs';
import { Id, Phone } from 'libs/domain';

export class AccountLockedEvent implements IEvent {
  constructor(
    readonly id: Id,
    readonly phone: Phone,
  ) {}
}
