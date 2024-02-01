import { Controller, Get, HttpStatus, Param } from '@nestjs/common';
import { QueryBus } from '@nestjs/cqrs';
import {
  ApiBadRequestResponse,
  ApiInternalServerErrorResponse,
  ApiNotFoundResponse,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { ResponseDescription } from 'src/account/interface/ResponseDescription';
import { GetLotteryResultByDayQuery } from '../application/query/GetLotteryResultByDayQuery';
import { GetLotteryResultByDayResult } from '../application/query/GetLotteryResultByDayResult';
import { Auth } from 'libs/Auth';

@ApiTags('lottery-result')
@Controller()
export class LotteryResultController {
  constructor(readonly queryBus: QueryBus) {}
  @Auth()
  @Get('lottery/:day')
  @ApiResponse({
    status: HttpStatus.OK,
    description: ResponseDescription.OK,
    type: GetLotteryResultByDayResult,
  })
  @ApiBadRequestResponse({ description: ResponseDescription.BAD_REQUEST })
  @ApiNotFoundResponse({ description: ResponseDescription.NOT_FOUND })
  @ApiInternalServerErrorResponse({
    description: ResponseDescription.INTERNAL_SERVER_ERROR,
  })
  async getLotteryResultByDay(
    @Param('day') day: string,
  ): Promise<GetLotteryResultByDayResult> {
    return this.queryBus.execute(new GetLotteryResultByDayQuery(day));
  }
}
