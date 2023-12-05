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
import { Id, Password, Phone } from 'libs/domain';
import { DeviceEntity } from '../entity/DeviceEntity';

import { DeviceRepository } from './DeviceRepository';
import { InjectionToken } from 'src/account/application/InjectionToken';
import { DeviceFactory } from 'src/account/domain/DeviceFactory';
import { ErrorMessage } from 'src/account/domain/ErrorMessage';

export class AccountRepository implements IAccountRepository {
  @Inject(InjectionToken.DEVICE_REPOSITORY)
  private readonly deviceRepository: DeviceRepository;
  @Inject() private readonly accountFactory: AccountFactory;
  @Inject() private readonly deviceFactory: DeviceFactory;
  @Inject(ENTITY_ID_TRANSFORMER)
  private readonly entityIdTransformer: EntityIdTransformer;

  async newId(): Promise<string> {
    return new EntityId().toString();
  }

  async save(account: IAccount | IAccount[]): Promise<IAccount[]> {
    try {
      const models = Array.isArray(account) ? account : [account];
      const entities = await Promise.all(
        models.map((model) => this.modelToEntity(model)),
      );
      if (account instanceof Account) {
        const entity = await writeConnection.manager
          .getRepository(AccountEntity)
          .findOneBy({ phone: entities[0].phone });
        if (entity)
          throw new BadRequestException(ErrorMessage.ACCOUNT_ALREADY_EXISTED);
      }
      return await writeConnection.manager
        .getRepository(AccountEntity)
        .save(entities)
        .then((entities) =>
          entities.map((entity) => this.entityToModel(entity)),
        );
      // return result.map((entity) => this.entityToModel(entity));
    } catch (error) {
      console.log(error);
    }
  }

  async findById(id: string): Promise<IAccount | null> {
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

  async updateDevice(accountId: string, deviceId: string): Promise<void> {
    //TODO: Refactor: apply transaction to this flow
    await Promise.all([
      writeConnection.manager
        .getRepository(AccountEntity)
        .update(accountId, { deviceId }),
      writeConnection.manager.getRepository(DeviceEntity).upsert(
        [
          {
            // id: Id.create().value,
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

  public async modelToEntity(model: IAccount): Promise<AccountEntity> {
    return new AccountEntity((await model.toPlainObject()) as AccountEntity);
  }

  public entityToModel(entity: AccountEntity): IAccount {
    return this.accountFactory.reconstitute({
      ...entity,
      phone: Phone.create({ value: entity.phone }),
      password: Password.create({ value: entity.password, hashed: true }),
      id: Id.from(entity.id),
      createdAt: entity.createdAt,
      devices: entity.devices.map((device) =>
        this.deviceRepository.entityToModel(device),
      ),
    });
  }
}
