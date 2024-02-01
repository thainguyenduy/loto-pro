import { Inject } from '@nestjs/common';
import { EventPublisher } from '@nestjs/cqrs';

import { IDevice, DeviceProps, Device } from './Device';
import { Id } from 'libs/domain';

type CreateDeviceOptions = Readonly<{
  accountId: Id;
  deviceId: string;
  active: boolean;
}>;

export class DeviceFactory {
  @Inject(EventPublisher) private readonly eventPublisher: EventPublisher;

  create(options: CreateDeviceOptions): IDevice {
    const dId = Id.create();
    return this.eventPublisher.mergeObjectContext(
      new Device({
        ...options,
        id: dId,
      }),
    ) as IDevice;
  }

  reconstitute(properties: DeviceProps): IDevice {
    return this.eventPublisher.mergeObjectContext(new Device(properties));
  }
}
