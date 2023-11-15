import { Logger } from '@nestjs/common';

const infrastructure: Provider[] = [ConfigService];

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
  async getLotteryResult(): Promise<void> {
    
  }
}
