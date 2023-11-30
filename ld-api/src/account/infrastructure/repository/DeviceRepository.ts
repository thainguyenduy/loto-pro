import { Inject } from '@nestjs/common';
import { IDeviceRepository } from 'src/account/application/IDeviceRepository';
import { IDevice } from 'src/account/domain/Device';
import { DeviceFactory } from 'src/account/domain/DeviceFactory';
import { DeviceEntity } from '../entity/DeviceEntity';
import { Id } from 'libs/domain';

export class DeviceRepository implements IDeviceRepository {
  @Inject() private readonly deviceFactory: DeviceFactory;
  public async modelToEntity(model: IDevice): Promise<DeviceEntity> {
    return new DeviceEntity(model.toPlainObject() as DeviceEntity);
  }

  public entityToModel(entity: DeviceEntity): IDevice {
    return this.deviceFactory.reconstitute({
      ...entity,
      id: Id.from(entity.id),
      accountId: Id.from(entity.accountId),
    });
  }
}
