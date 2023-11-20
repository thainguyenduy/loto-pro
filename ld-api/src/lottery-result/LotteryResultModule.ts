import { Inject, Logger, Module, Provider } from '@nestjs/common';
import { InjectionToken } from './application/InjectionToken';
import { LotteryResultRepository } from './infrastructure/repository/LotteryResultRepository';
import { LotteryResultFactory } from './domain/LotteryResultFactory';
import { CommandBus, CqrsModule } from '@nestjs/cqrs';
import { Cron } from '@nestjs/schedule';
import { GetLotteryResultCommand } from './application/command/GetLotteryResultCommand';
import { Day } from 'libs/domain';
import { GetLotteryResultCommandHandler } from './application/command/GetLotteryResultCommandHandler';
import { LotteryResultService } from './infrastructure/service/LotteryResultService';
import { LotteryResultController } from './interface/LotteryResultController';
import { GetLotteryResultByDayHandler } from './application/query/GetLotteryResultByDayHandler';
import { LotteryResultQuery } from './infrastructure/query/LotteryResultQuery';
import { JwtModule, JwtService } from '@nestjs/jwt';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { AuthGuard } from 'libs/Auth';

const infrastructure: Provider[] = [
  {
    provide: InjectionToken.LOTTERY_RESULT_REPOSITORY,
    useClass: LotteryResultRepository,
  },
  {
    provide: InjectionToken.LOTTERY_RESULT_SERVICE,
    useClass: LotteryResultService,
  },
  {
    provide: InjectionToken.LOTTERY_RESULT_QUERY,
    useClass: LotteryResultQuery,
  },
  ConfigService,
  JwtService,
  AuthGuard,
];

const application = [
  GetLotteryResultCommandHandler,
  GetLotteryResultByDayHandler,
];

const domain = [LotteryResultFactory];

@Module({
  imports: [
    CqrsModule,
    // JwtModule.registerAsync({
    //   imports: [ConfigModule],
    //   global: true,
    //   useFactory: async (configService: ConfigService) => ({
    //     secretOrPrivateKey: configService.get<string>('SECRET_KEY'),
    //     // secretOrPrivateKey: '1233',
    //     signOptions: {
    //       expiresIn: 3600,
    //     },
    //   }),
    //   inject: [ConfigService],
    // }),
  ],
  providers: [Logger, ...infrastructure, ...application, ...domain],

  controllers: [LotteryResultController],
})
export class LotteryResultModule {
  @Inject() private commandBus: CommandBus;

  @Cron('0 30 18 * * 1-7')
  // @Cron('0 * * * * *')
  async getLotteryResult(): Promise<void> {
    this.commandBus.execute(
      new GetLotteryResultCommand(Day.create(new Date())),
    );
  }
}
