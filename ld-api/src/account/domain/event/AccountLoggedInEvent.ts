import { IEvent } from '@nestjs/cqrs';
import { Phone } from '../../../../libs/domain';

export class AccountLoggedInEvent implements IEvent {
  constructor(
    readonly id: number,
    readonly deviceId: string,
    readonly phone: Phone,
  ) {}
}
