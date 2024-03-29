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
import { ILotteryResultService } from '../../application/ILotteryResultService';
import { ILotteryResult } from '../../domain/LotteryResult';
import { LotteryResultFactory } from '../../domain/LotteryResultFactory';
import { Inject, Logger } from '@nestjs/common';
import puppeteer, { Page, executablePath } from 'puppeteer-core';

// require executablePath from puppeteer

const DEFAULT_NAVIGATION_TIMEOUT = 2 * 60 * 1000;
export interface IParserResultStrategy {
  readonly endpoint: string;
  parse: (page: Page, day: string) => Promise<string[][]>;
}
export class LotteryResultService implements ILotteryResultService {
  @Inject() private readonly lotteryResultFactory: LotteryResultFactory;
  private parserStrategy: IParserResultStrategy;
  private readonly logger = new Logger(LotteryResultService.name);

  set parser(parser: IParserResultStrategy) {
    this.parserStrategy = parser;
  }
  async getLotteryResult(day: Day): Promise<ILotteryResult> {
    const browser = await puppeteer.launch({
      headless: false,

      // add this
      executablePath: executablePath('chrome'),
    });
    try {
      const page = await browser.newPage();
      page.setDefaultNavigationTimeout(DEFAULT_NAVIGATION_TIMEOUT);
      const data = await this.parserStrategy.parse(page, day.value);
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
    } catch (e) {
      this.logger.error(e);
    } finally {
      await browser.close();
    }
  }
}
export class KQXSParserResultStrategy implements IParserResultStrategy {
  endpoint: string = 'https://xoso.com.vn/';
  private readonly queryIds: string[] = [
    'mb_prize_DB',
    'mb_prize_1',
    'mb_prize_2',
    'mb_prize_3',
    'mb_prize_4',
    'mb_prize_5',
    'mb_prize_6',
    'mb_prize_7',
  ];
  async parse(page: Page, day: string): Promise<string[][]> {
    await Promise.all([
      page.waitForNavigation(),
      page.goto(`${this.endpoint}kqxs-${day}.html`),
    ]);
    const queries = this.queryIds.map((id) => {
      return page.$$eval(`[id^='${id}']`, (items: HTMLInputElement[]) => {
        return items.map((item) => item.innerHTML.trim() || '');
      });
    });
    return await Promise.all(queries);
  }
}
export class SXDaiPhatParserResultStrategy implements IParserResultStrategy {
  day: string;
  public readonly endpoint: string = 'https://xosodaiphat.com/';
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
  async parse(page: Page, day: string): Promise<string[][]> {
    await Promise.all([
      page.waitForNavigation(),
      page.goto(`${this.endpoint}xsmb-${day}.html`),
    ]);
    const queries = this.queryIds.map((id) => {
      return page.$$eval(`[id^='${id}']`, (items: HTMLInputElement[]) => {
        return items.map((item) => item.innerHTML.trim() || '');
      });
    });
    return await Promise.all(queries);
  }
}
