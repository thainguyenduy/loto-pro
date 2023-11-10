import { Inject } from '@nestjs/common';

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

export class AccountRepository implements IAccountRepository {
  @Inject() private readonly accountFactory: AccountFactory;
  @Inject(ENTITY_ID_TRANSFORMER)
  private readonly entityIdTransformer: EntityIdTransformer;

  async newId(): Promise<string> {
    return new EntityId().toString();
  }

  async save(data: Account | Account[]): Promise<void> {
    const models = Array.isArray(data) ? data : [data];
    const entities = await Promise.all(
      models.map((model) => this.modelToEntity(model)),
    );
    await writeConnection.manager.getRepository(AccountEntity).save(entities);
  }

  async findById(id: string): Promise<IAccount | null> {
    const entity = await writeConnection.manager
      .getRepository(AccountEntity)
      .findOneBy({ id: this.entityIdTransformer.to(id) });
    return entity ? this.entityToModel(entity) : null;
  }

  async findByPhone(phone: string): Promise<IAccount[]> {
    const entities = await writeConnection.manager
      .getRepository(AccountEntity)
      .findBy({ phone: Like(phone) });
    return entities.map((entity) => this.entityToModel(entity));
  }
  async updateDevice(accountId: string, deviceId: string): Promise<void> {
    await writeConnection.manager
      .getRepository(AccountEntity)
      .update(accountId, { deviceId });
  }

  private async modelToEntity(model: Account): Promise<AccountEntity> {
    return new AccountEntity({
      ...model,
      id: this.entityIdTransformer.to(model.Id),
      phone: model.getPhone,
      password: await model.getHashedPassword,
      activated: model.isActivated,
      deviceId: model.getDeviceId,
      createdAt: model.getCreatedAt,
      updatedAt: model.getUpdatedAt,
      lockedAt: model.getLockedAt,
      expirationDate: model.getExpirationDate,
      devices: [],
    });
  }

  private entityToModel(entity: AccountEntity): IAccount {
    return this.accountFactory.reconstitute({
      ...entity,
      phone: Phone.create({ value: entity.phone }),
      password: Password.create({ value: entity.password, hashed: true }),
      id: this.entityIdTransformer.from(entity.id),
      createdAt: entity.createdAt,
    });
  }
}
