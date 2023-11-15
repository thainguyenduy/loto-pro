type K = "giaidacbiet"|"giainhat";

import {
  GiaiBa,
  GiaiBay,
  GiaiDacBiet,
  GiaiNam,
  GiaiNhat,
  GiaiNhi,
  GiaiSau,
  GiaiTu,
} from 'libs/domain';
import { ILotteryResultService } from '../application/ILotteryResultService';
import { ILotteryResult } from '../domain/LotteryResult';
import { LotteryResultFactory } from '../domain/LotteryResultFactory';
import { Inject } from '@nestjs/common';

export interface IParserContentStrategy {
  url: string;
  parse: (content: any) => Promise<ILotteryResult>;
}
export class LotteryResultService implements ILotteryResultService {
  private _parser: IParserContentStrategy;
  constructor(
    @InjectContext() private readonly browserContext: BrowserContext,
    ) {}
  set parser(parser: IParserContentStrategy) {
      this._parser = parser;
    }
  async getLotteryResult(day: string): Promise<ILotteryResult> {
    let data: Record<K, any[]>;
    const page = await this.browserContext.newPage();
    await page.goto(this._parser.url);
    
    data = await this._parser.parse(await page.content());
    return this.lotteryResultFactory.create({
      giaiDacBiet: GiaiDacBiet.create({ value: data.giaidacbiet }),
      giaiNhat: GiaiNhat.create({ value: data[1] }),
      giaiNhi: GiaiNhi.create({ value: data[2] }),
      giaiBa: GiaiBa.create({ value: data[3] }),
      giaiTu: GiaiTu.create({ value: data[4] }),
      giaiNam: GiaiNam.create({ value: data[5] }),
      giaiSau: GiaiSau.create({ value: data[6] }),
      giaiBay: GiaiBay.create({ value: data[7] }),
    });
  }
  }
  
}

export class SXMBParserContentStrategy implements IParserContentStrategy {
  @Inject() private readonly lotteryResultFactory: LotteryResultFactory;
  public readonly url: string = 'https://xosodaiphat.com/xsmb-xo-so-mien-bac.html';
  parse(content: any): Promise<ILotteryResult> {
    let data: Record<K, any[]>;
    
  }
}
