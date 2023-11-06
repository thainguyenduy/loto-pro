import { Inject, Injectable } from '@nestjs/common';

import {
  EntityIdTransformer,
  ENTITY_ID_TRANSFORMER,
  readConnection,
} from 'libs/DatabaseModule';

import { AccountEntity } from 'src/account/infrastructure/entity/AccountEntity';

import { FindAccountByIdResult } from 'src/account/application/query/FindAccountByIdResult';
import { FindAccountsResult } from 'src/account/application/query/FindAccountsResult';
import { FindAccountsQuery } from 'src/account/application/query/FindAccountsQuery';
import { IAccountQuery } from 'src/account/application/query/IAccountQuery';
import { Like } from 'typeorm';

@Injectable()
export class AccountQuery implements IAccountQuery {
  @Inject(ENTITY_ID_TRANSFORMER)
  private readonly entityIdTransformer: EntityIdTransformer;

  async findById(id: string): Promise<FindAccountByIdResult | null> {
    return readConnection
      .getRepository(AccountEntity)
      .findOneBy({ id: this.entityIdTransformer.to(id) })
      .then((entity) =>
        entity
          ? { ...entity, id: this.entityIdTransformer.from(entity.id) }
          : null,
      );
  }

  async findByPhone(query: FindAccountsQuery): Promise<FindAccountsResult> {
    return readConnection
      .getRepository(AccountEntity)
      .find({
        where: { phone: Like(query.phone) },
        skip: query.skip,
        take: query.take,
      })
      .then(
        (entities) =>
          new FindAccountsResult(
            entities.map((entity) => ({
              ...entity,
              id: this.entityIdTransformer.from(entity.id),
            })),
          ),
      );
  }
}
