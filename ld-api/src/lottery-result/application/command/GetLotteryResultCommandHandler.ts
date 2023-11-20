import { CommandHandler, ICommandHandler } from '@nestjs/cqrs';
import {
  KQXSParserResultStrategy,
  LotteryResultService,
  SXDaiPhatParserResultStrategy,
} from 'src/lottery-result/infrastructure/service/LotteryResultService';
import { ILotteryResultService } from '../ILotteryResultService';
import { ILotteryResult } from 'src/lottery-result/domain/LotteryResult';
import { Inject, Logger } from '@nestjs/common';
import { GetLotteryResultCommand } from './GetLotteryResultCommand';
import { ILotteryResultRepository } from 'src/lottery-result/application/ILotteryResultRepository';
import { InjectionToken } from 'src/lottery-result/application/InjectionToken';

@CommandHandler(GetLotteryResultCommand)
export class GetLotteryResultCommandHandler
  implements ICommandHandler<GetLotteryResultCommand, void>
{
  private readonly logger = new Logger(LotteryResultService.name);
  @Inject(InjectionToken.LOTTERY_RESULT_REPOSITORY)
  private readonly lotteryResultRepository: ILotteryResultRepository;
  @Inject(InjectionToken.LOTTERY_RESULT_SERVICE)
  private readonly lotteryResultService: ILotteryResultService;
  async execute(command: GetLotteryResultCommand): Promise<void> {
    try {
      this.lotteryResultService.parser = new KQXSParserResultStrategy();
      const src1: ILotteryResult =
        await this.lotteryResultService.getLotteryResult(command.day);
      this.lotteryResultService.parser = new SXDaiPhatParserResultStrategy();
      const src2: ILotteryResult =
        await this.lotteryResultService.getLotteryResult(command.day);
      if (src2.compare(src1)) await this.lotteryResultRepository.save(src1);
    } catch (error) {
      this.logger.error(error);
    }
  }
}
