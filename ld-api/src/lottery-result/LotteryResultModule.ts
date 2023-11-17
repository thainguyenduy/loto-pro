import { Inject, Logger, Module, Provider } from '@nestjs/common';
import { InjectionToken } from './application/InjectionToken';
import { LotteryResultRepository } from './infrastructure/repository/LotteryResultRepository';
import { LotteryResultFactory } from './domain/LotteryResultFactory';
import { CommandBus, CqrsModule } from '@nestjs/cqrs';
import { Cron, CronExpression } from '@nestjs/schedule';
import { GetLotteryResultCommand } from './application/command/GetLotteryResultCommand';
import { Day } from 'libs/domain';

const infrastructure: Provider[] = [
  {
    provide: InjectionToken.LOTTERY_RESULT_REPOSITORY,
    useClass: LotteryResultRepository,
  },
];

const application = [];

const domain = [LotteryResultFactory];

@Module({
  imports: [CqrsModule],
  // controllers: [LotteryResultController],
  providers: [Logger, ...infrastructure, ...application, ...domain],
})
export class LotteryResultModule {
  @Inject() private commandBus: CommandBus;
  @Cron(CronExpression.EVERY_SECOND)
  async getLotteryResult(): Promise<void> {
    this.commandBus.execute(
      new GetLotteryResultCommand(Day.create('19/11/2023')),
    );
  }
}
