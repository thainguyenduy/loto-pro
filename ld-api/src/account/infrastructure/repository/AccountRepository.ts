import { BadRequestException, Inject } from '@nestjs/common';

import {
  EntityId,
  EntityIdTransformer,
  ENTITY_ID_TRANSFORMER,
  writeConnection,
} from 'libs/DatabaseModule';

import { AccountEntity } from 'src/account/infrastructure/entity/AccountEntity';

import { Account, IAccount } from 'src/account/domain/Account';
import { AccountFactory } from 'src/account/domain/AccountFactory';
import { IAccountRepository } from 'src/account/application/IAccountRepository';
import { Like } from 'typeorm';
import { Password, Phone } from 'libs/domain';
import { DeviceEntity } from '../entity/DeviceEntity';
import { InfraErrorMessage } from 'src/lottery-result/infrastructure/InfraErrorMessage';
import { DeviceRepository } from './DeviceRepository';

export class AccountRepository implements IAccountRepository {
  @Inject() private readonly accountFactory: AccountFactory;
  @Inject() private readonly deviceRepository: DeviceRepository;
  @Inject(ENTITY_ID_TRANSFORMER)
  private readonly entityIdTransformer: EntityIdTransformer;

  async newId(): Promise<string> {
    return new EntityId().toString();
  }

  async save(data: Account | Account[]): Promise<IAccount[]> {
    const models = Array.isArray(data) ? data : [data];
    const entities = await Promise.all(
      models.map((model) => this.modelToEntity(model)),
    );
    if (data instanceof Account) {
      const entity = await writeConnection.manager
        .getRepository(AccountEntity)
        .findOneBy({ phone: data.getPhone });
      if (entity)
        throw new BadRequestException(
          InfraErrorMessage.DAILY_LOTTERY_RESULT_EXISTED,
        );
    }
    return await writeConnection.manager
      .getRepository(AccountEntity)
      .save(entities)
      .then((entities) => entities.map((entity) => this.entityToModel(entity)));
    // return result.map((entity) => this.entityToModel(entity));
  }

  async findById(id: number): Promise<IAccount | null> {
    const entity = await writeConnection.manager
      .getRepository(AccountEntity)
      .findOneBy({ id });
    return entity ? this.entityToModel(entity) : null;
  }

  async findByPhone(phone: string): Promise<IAccount[]> {
    const entities = await writeConnection.manager
      .getRepository(AccountEntity)
      .findBy({ phone: Like(phone) });
    return entities.map((entity) => this.entityToModel(entity));
  }

  async updateDevice(accountId: number, deviceId: string): Promise<void> {
    //TODO: Refactor: apply transaction to this flow
    await Promise.all([
      writeConnection.manager
        .getRepository(AccountEntity)
        .update(accountId, { deviceId }),
      writeConnection.manager.getRepository(DeviceEntity).upsert(
        [
          {
            updatedAt: new Date(),
            accountId: accountId,
            deviceId,
            active: true,
          },
        ],
        ['deviceId'],
      ),
    ]);
    return;
  }

  public async modelToEntity(model: Account): Promise<AccountEntity> {
    return new AccountEntity({
      ...model,
      id: model.Id,
      phone: model.getPhone,
      password: await model.getHashedPassword,
      activated: model.isActivated,
      deviceId: model.getDeviceId,
      createdAt: model.getCreatedAt,
      updatedAt: model.getUpdatedAt,
      lockedAt: model.getLockedAt,
      expirationDate: model.getExpirationDate,
      devices: await Promise.all(
        model.devices.map(
          async (device) => await this.deviceRepository.modelToEntity(device),
        ),
      ),
      // devices: await this.deviceRepository.modelToEntity(model.devices),
    });
  }

  public entityToModel(entity: AccountEntity): IAccount {
    return this.accountFactory.reconstitute({
      ...entity,
      phone: Phone.create({ value: entity.phone }),
      password: Password.create({ value: entity.password, hashed: true }),
      id: entity.id,
      createdAt: entity.createdAt,
    });
  }
}
