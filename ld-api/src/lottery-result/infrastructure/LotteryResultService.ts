import type { BrowserContext, Page } from 'puppeteer';
import { InjectContext } from 'nest-puppeteer';

import {
  Day,
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
  parse: (page: Page) => Promise<string[][]>;
}
export class LotteryResultService implements ILotteryResultService {
  @Inject() private readonly lotteryResultFactory: LotteryResultFactory;
  private _parser: IParserContentStrategy;
  constructor(
    @InjectContext() private readonly browserContext: BrowserContext,
  ) {}
  set parser(parser: IParserContentStrategy) {
    this._parser = parser;
  }
  async getLotteryResult(day: Day): Promise<ILotteryResult> {
    // let data: Record<K, any[]>;
    const page = await this.browserContext.newPage();
    await page.goto(this._parser.url);
    const data = await this._parser.parse(page);
    await this.browserContext.close();
    return this.lotteryResultFactory.create({
      giaiDacBiet: GiaiDacBiet.create({ value: data[0] }),
      giaiNhat: GiaiNhat.create({ value: data[1] }),
      giaiNhi: GiaiNhi.create({ value: data[2] }),
      giaiBa: GiaiBa.create({ value: data[3] }),
      giaiTu: GiaiTu.create({ value: data[4] }),
      giaiNam: GiaiNam.create({ value: data[5] }),
      giaiSau: GiaiSau.create({ value: data[6] }),
      giaiBay: GiaiBay.create({ value: data[7] }),
      day: day,
    });
  }
}

export class SXMBParserContentStrategy implements IParserContentStrategy {
  public readonly url: string =
    'https://xosodaiphat.com/xsmb-xo-so-mien-bac.html';
  public readonly queryIds: string[] = [
    'mb_prize_DB',
    'mb_prize_1',
    'mb_prize_2',
    'mb_prize_3',
    'mb_prize_4',
    'mb_prize_5',
    'mb_prize_6',
    'mb_prize_7',
  ];
  async parse(page: Page): Promise<string[][]> {
    let data: string[][];
    await page.evaluate(() => {
      for (let i = 0; i < this.queryIds.length; i++) {
        data[i] = this.selectPrize(this.queryIds[i]);
      }
    });
    return data;
  }

  private selectPrize(id: string): string[] {
    const prize = [];
    const prizeTags = document.querySelectorAll(`'[id^="${id}"]'`);
    prizeTags.forEach((prizeTag) => {
      prize.push(prizeTag.innerHTML);
    });
    return prize;
  }
}
