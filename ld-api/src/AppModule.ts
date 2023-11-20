import { ThrottlerGuard, ThrottlerModule } from '@nestjs/throttler';
import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { ScheduleModule } from '@nestjs/schedule';
import { APP_GUARD } from '@nestjs/core';

import { DatabaseModule } from 'libs/DatabaseModule';
import { RequestStorageMiddleware } from 'libs/RequestStorageMiddleware';

import { AppController } from 'src/AppController';
import { AppService } from 'src/AppService';
import { AccountsModule } from './account/AccountModule';
import { CacheModule } from '@nestjs/cache-manager';
import { ConfigModule } from '@nestjs/config';
import { LotteryResultModule } from './lottery-result/LotteryResultModule';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: '.env',
    }),
    AccountsModule,
    LotteryResultModule,
    DatabaseModule,
    CacheModule.register({ isGlobal: true }),
    ThrottlerModule.forRoot(),
    ScheduleModule.forRoot(),
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_GUARD,
      useClass: ThrottlerGuard,
    },
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(RequestStorageMiddleware).forRoutes('*');
  }
}
