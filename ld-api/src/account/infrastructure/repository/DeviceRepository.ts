import { Inject } from '@nestjs/common';
import { IDeviceRepository } from 'src/account/application/IDeviceRepository';
import { Device, IDevice } from 'src/account/domain/Device';
import { DeviceFactory } from 'src/account/domain/DeviceFactory';
import { DeviceEntity } from '../entity/DeviceEntity';
import { AccountRepository } from './AccountRepository';

export class DeviceRepository implements IDeviceRepository {
  @Inject() private readonly deviceFactory: DeviceFactory;
  @Inject() private readonly accountRepository: AccountRepository;
  public async modelToEntity(model: Device): Promise<DeviceEntity> {
    return new DeviceEntity({
      ...model,
      id: model.Id,
      active: model.active,
      accountId: model.getAccountId,
      deviceId: model.getDeviceId,
      createdAt: model.getCreatedAt,
      updatedAt: model.getUpdatedAt,
      lockedAt: model.getLockedAt,
      account: await this.accountRepository.modelToEntity(model.account),
    });
  }

  public entityToModel(entity: DeviceEntity): IDevice {
    return this.deviceFactory.reconstitute({
      ...entity,
      id: entity.id,
      deviceId: entity.deviceId,
      active: entity.active,
      accountId: entity.accountId,
      createdAt: entity.createdAt,
    });
  }
}
