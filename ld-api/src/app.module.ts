import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AccountModule } from './account/account.module';
import { ContactModule } from './contact/contact.module';
import { LotteryModule } from './lottery/lottery.module';
import { BetModule } from './bet/bet.module';
import { DebtModule } from './debt/debt.module';

@Module({
  imports: [AccountModule, ContactModule, LotteryModule, BetModule, DebtModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
