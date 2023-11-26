import { Inject } from '@nestjs/common';
import { EventPublisher } from '@nestjs/cqrs';

import { IDevice, DeviceProps, Device } from './Device';

type CreateDeviceOptions = Readonly<{
  deviceId: string;
  active: boolean;
  accountId: number;
}>;

export class DeviceFactory {
  @Inject(EventPublisher) private readonly eventPublisher: EventPublisher;

  create(options: CreateDeviceOptions): IDevice {
    return this.eventPublisher.mergeObjectContext(
      Device.create({
        ...options,
        id: null,
        lockedAt: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      }),
    );
  }

  reconstitute(properties: DeviceProps): IDevice {
    return this.eventPublisher.mergeObjectContext(Device.create(properties));
  }
}
