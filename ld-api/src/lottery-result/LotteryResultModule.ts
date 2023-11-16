import { Logger } from '@nestjs/common';
import { InjectionToken } from './application/InjectionToken';

const infrastructure: Provider[] = [
  ConfigService,
  {
    provide: InjectionToken.LOTTERY_RESULT_REPOSITORY,
    useClass: LotteryResultRepository,
  },
];

const application = [];

const domain = [LotteryResultFactory];

@Module({
  imports: [CqrsModule],
  controllers: [LotteryResultController],
  providers: [Logger, ...infrastructure, ...application, ...domain],
})
export class AccountsModule {
  // TODO:
  @Cron(CronExpression.EVERY_DAY_AT_MIDNIGHT)
  async getLotteryResult(): Promise<void> {}
}
