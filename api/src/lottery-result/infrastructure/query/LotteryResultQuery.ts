import { Inject, Injectable } from '@nestjs/common';

import {
  EntityIdTransformer,
  ENTITY_ID_TRANSFORMER,
  readConnection,
} from 'libs/DatabaseModule';

import { ILotteryResultQuery } from 'src/lottery-result/application/query/ILotteryResultQuery';
import { LotteryResultEntity } from '../entity/LotteryResultEntity';

@Injectable()
export class LotteryResultQuery implements ILotteryResultQuery {
  @Inject(ENTITY_ID_TRANSFORMER)
  private readonly entityIdTransformer: EntityIdTransformer;

  async findByDay(day: string): Promise<LotteryResultEntity> {
    return readConnection
      .getRepository(LotteryResultEntity)
      .findOneBy({ day })
      .then((entity) => entity || null);
  }
}
