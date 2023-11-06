import { ThrottlerGuard, ThrottlerModule } from '@nestjs/throttler';
import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import { ScheduleModule } from '@nestjs/schedule';

import { DatabaseModule } from 'libs/DatabaseModule';
import { RequestStorageMiddleware } from 'libs/RequestStorageMiddleware';

import { AppController } from 'src/AppController';
import { AppService } from 'src/AppService';
import { AccountsModule } from './account/AccountModule';
import { CacheModule } from '@nestjs/cache-manager';

@Module({
  imports: [
    AccountsModule,
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
