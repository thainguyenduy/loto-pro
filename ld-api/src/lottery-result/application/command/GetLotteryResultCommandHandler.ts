import { ICommand, ICommandHandler } from '@nestjs/cqrs';
import { Day } from 'libs/domain';
import { SXMBParserContent } from 'src/lottery-result/infrastructure/LotteryResultService';
import { ILotteryResultService } from '../ILotteryResultService';
import { ILotteryResult } from 'src/lottery-result/domain/LotteryResult';
import { Inject } from '@nestjs/common';
import { GetLotteryResultCommand } from './GetLotteryResultCommand';

export class GetLotteryResultCommandHandler implements ICommandHandler<GetLotteryResultCommand, void> {
  @Inject() private readonly lotteryResultService: ILotteryResultService;
  execute(command: GetLotteryResultCommand): Promise<void> {
    this.lotteryResultService.parser = new SXMBParserContentStrategy();
    src1: ILotteryResult = await this.lotteryResultService.getLotteryResult('20/11/2023');

    if src2.compare(src1);
    this.lotteryResultRepository.save(src1)
    return
  }
}
