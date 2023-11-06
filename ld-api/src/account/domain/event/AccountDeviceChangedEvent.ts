import { IEvent } from '@nestjs/cqrs';

export class AccountDeviceChangedEvent implements IEvent {
  constructor(
    readonly id: string,
    readonly deviceId: string,
    readonly phone: string,
  ) {}
}
