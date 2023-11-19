import { BadRequestException, Inject } from '@nestjs/common';

import { writeConnection } from 'libs/DatabaseModule';

import * as domain from 'libs/domain';
import { ILotteryResultRepository } from 'src/lottery-result/application/ILotteryResultRepository';
import { LotteryResultFactory } from 'src/lottery-result/domain/LotteryResultFactory';
import {
  ILotteryResult,
  LotteryResult,
} from 'src/lottery-result/domain/LotteryResult';
import { LotteryResultEntity } from '../entity/LotteryResultEntity';
import { Day, GiaiBay, GiaiDacBiet, GiaiSau } from 'libs/domain';
import { ErrorMessage } from 'src/account/infrastructure/ErrorMessage';

export class LotteryResultRepository implements ILotteryResultRepository {
  findResultByDay: (day: domain.Day) => Promise<ILotteryResult>;
  @Inject() private readonly lotteryResultFactory: LotteryResultFactory;

  async save(lotteryResult: LotteryResult): Promise<ILotteryResult> {
    const lotteryResultEntity = this.modelToEntity(lotteryResult);

    const entity = await writeConnection.manager
      .getRepository(LotteryResultEntity)
      .findOneBy({ day: lotteryResult.day.value });
    if (entity)
      throw new BadRequestException(ErrorMessage.DAILY_LOTTERY_RESULT_EXISTED);

    return await writeConnection.manager
      .getRepository(LotteryResultEntity)
      .save(lotteryResultEntity)
      .then((entity) => this.entityToModel(entity));
    // return result.map((entity) => this.entityToModel(entity));
  }

  private modelToEntity(model: LotteryResult) {
    return new LotteryResultEntity({
      ...model,
      id: model.Id,
      giaiDacBiet: model.giaiDacBiet.value,
      giaiNhat: model.giaiNhat.value,
      giaiNhi: model.giaiNhi.value,
      giaiBa: model.giaiBa.value,
      giaiTu: model.giaiTu.value,
      giaiNam: model.giaiNam.value,
      giaiSau: model.giaiSau.value,
      giaiBay: model.giaiBay.value,
      day: model.day.value,
    });
  }

  private entityToModel(entity: LotteryResultEntity): ILotteryResult {
    return this.lotteryResultFactory.reconstitute({
      ...entity,
      id: entity.id,
      giaiDacBiet: GiaiDacBiet.create({
        value: entity.giaiDacBiet,
      }),
      giaiNhat: domain.GiaiNhat.create({
        value: entity.giaiNhat,
      }),
      giaiNhi: domain.GiaiNhi.create({
        value: entity.giaiNhi,
      }),
      giaiBa: domain.GiaiBa.create({
        value: entity.giaiBa,
      }),
      giaiTu: domain.GiaiTu.create({
        value: entity.giaiTu,
      }),
      giaiNam: domain.GiaiNam.create({
        value: entity.giaiNam,
      }),
      giaiSau: GiaiSau.create({
        value: entity.giaiSau,
      }),
      giaiBay: GiaiBay.create({
        value: entity.giaiBay,
      }),
      day: Day.create(entity.day),
    });
  }
}
