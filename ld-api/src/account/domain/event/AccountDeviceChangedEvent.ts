import { IEvent } from '@nestjs/cqrs';
import { Phone } from '../../../../libs/domain';

export class AccountDeviceChangedEvent implements IEvent {
  constructor(
    readonly id: number,
    readonly deviceId: string,
    readonly phone: Phone,
  ) {}
}
