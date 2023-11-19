import { Inject, Logger, Module, Provider } from '@nestjs/common';
import { InjectionToken } from './application/InjectionToken';
import { LotteryResultRepository } from './infrastructure/repository/LotteryResultRepository';
import { LotteryResultFactory } from './domain/LotteryResultFactory';
import { CommandBus, CqrsModule } from '@nestjs/cqrs';
import { Cron, CronExpression } from '@nestjs/schedule';
import { GetLotteryResultCommand } from './application/command/GetLotteryResultCommand';
import { Day } from 'libs/domain';
import { GetLotteryResultCommandHandler } from './application/command/GetLotteryResultCommandHandler';
import { LotteryResultService } from './infrastructure/service/LotteryResultService';
import moment from 'moment';

const infrastructure: Provider[] = [
  {
    provide: InjectionToken.LOTTERY_RESULT_REPOSITORY,
    useClass: LotteryResultRepository,
  },
  {
    provide: InjectionToken.LOTTERY_RESULT_SERVICE,
    useClass: LotteryResultService,
  },
];

const application = [GetLotteryResultCommandHandler];

const domain = [LotteryResultFactory];

@Module({
  imports: [CqrsModule],
  // controllers: [LotteryResultController],
  providers: [Logger, ...infrastructure, ...application, ...domain],
})
export class LotteryResultModule {
  @Inject() private commandBus: CommandBus;

  // @Cron('0 30 18 * * 1-7')
  @Cron('1 * * * * *')
  async getLotteryResult(): Promise<void> {
    this.commandBus.execute(
      new GetLotteryResultCommand(
        Day.create(moment(new Date()).format('DD-MM-YYYY')),
      ),
    );
  }
}
