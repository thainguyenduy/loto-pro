import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  Patch,
  Query,
  UseInterceptors,
  HttpStatus,
  Headers,
  ParseIntPipe,
} from '@nestjs/common';
import { CommandBus, QueryBus } from '@nestjs/cqrs';
import {
  ApiBadRequestResponse,
  ApiInternalServerErrorResponse,
  ApiNotFoundResponse,
  ApiResponse,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';

import { Auth, AuthorizedHeader } from 'libs/Auth';

import { FindAccountsRequestQueryString } from 'src/account/interface/dto/FindAccountsRequestQueryString';
import { OpenAccountRequestDTO } from 'src/account/interface/dto/OpenAccountRequestDTO';
import { UpdatePasswordRequestDTO } from 'src/account/interface/dto/UpdatePasswordRequestDTO';
import { UpdatePasswordRequestParam } from 'src/account/interface/dto/UpdatePasswordRequestParam';
import { FindAccountByIdResponseDTO } from 'src/account/interface/dto/FindAccountByIdResponseDTO';
import { FindAccountsResponseDto } from 'src/account/interface/dto/FindAccountsResponseDto';
import { LoginRequestParam } from './dto/LoginRequestParam';
import { LoginAccountQuery } from '../application/query/LoginAccountQuery';
import { ResponseDescription } from 'src/account/interface/ResponseDescription';

import { OpenAccountCommand } from 'src/account/application/command/OpenAccountCommand';
import { UpdatePasswordCommand } from 'src/account/application/command/UpdatePasswordCommand';
import { FindAccountByIdQuery } from 'src/account/application/query/FindAccountByIdQuery';
import { FindAccountsQuery } from 'src/account/application/query/FindAccountsQuery';

import { CacheInterceptor } from '@nestjs/cache-manager';
import { LoginRequestResponseDTO } from './dto/LoginRequestResponseDto';

@ApiTags('Accounts')
@Controller()
export class AccountsController {
  constructor(
    readonly commandBus: CommandBus,
    readonly queryBus: QueryBus,
  ) {}

  @Post('login')
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: ResponseDescription.CREATED,
  })
  @ApiBadRequestResponse({ description: ResponseDescription.BAD_REQUEST })
  @ApiInternalServerErrorResponse({
    description: ResponseDescription.INTERNAL_SERVER_ERROR,
  })
  async signIn(
    @Body() body: LoginRequestParam,
  ): Promise<LoginRequestResponseDTO> {
    return this.queryBus.execute(
      new LoginAccountQuery(body.phone, body.password, body.deviceId),
    );
  }

  @Post('accounts')
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: ResponseDescription.CREATED,
  })
  @ApiBadRequestResponse({ description: ResponseDescription.BAD_REQUEST })
  @ApiInternalServerErrorResponse({
    description: ResponseDescription.INTERNAL_SERVER_ERROR,
  })
  async openAccount(@Body() body: OpenAccountRequestDTO): Promise<void> {
    const command = new OpenAccountCommand(
      body.phone,
      body.password,
      body.deviceId,
    );
    await this.commandBus.execute(command);
  }

  @Auth()
  @Patch('accounts/:accountId/password')
  @ApiResponse({ status: HttpStatus.OK, description: ResponseDescription.OK })
  @ApiBadRequestResponse({ description: ResponseDescription.BAD_REQUEST })
  @ApiNotFoundResponse({ description: ResponseDescription.NOT_FOUND })
  @ApiUnauthorizedResponse({ description: ResponseDescription.UNAUTHORIZED })
  @ApiInternalServerErrorResponse({
    description: ResponseDescription.INTERNAL_SERVER_ERROR,
  })
  async updatePassword(
    @Headers() header: AuthorizedHeader,
    @Param() param: UpdatePasswordRequestParam,
    @Body() body: UpdatePasswordRequestDTO,
  ): Promise<void> {
    await this.commandBus.execute(
      new UpdatePasswordCommand(param.accountId, body.password),
    );
  }

  @Get('accounts')
  @UseInterceptors(CacheInterceptor)
  @ApiResponse({
    status: HttpStatus.OK,
    description: ResponseDescription.OK,
    type: FindAccountsResponseDto,
  })
  @ApiBadRequestResponse({ description: ResponseDescription.BAD_REQUEST })
  @ApiInternalServerErrorResponse({
    description: ResponseDescription.INTERNAL_SERVER_ERROR,
  })
  async findAccounts(
    @Query() querystring: FindAccountsRequestQueryString,
  ): Promise<FindAccountsResponseDto> {
    const query = new FindAccountsQuery(querystring);
    return { accounts: await this.queryBus.execute(query) };
  }

  @Auth()
  @Get('accounts/:accountId')
  // @UseInterceptors(CacheInterceptor)
  @ApiResponse({
    status: HttpStatus.OK,
    description: ResponseDescription.OK,
    type: FindAccountByIdResponseDTO,
  })
  @ApiBadRequestResponse({ description: ResponseDescription.BAD_REQUEST })
  @ApiNotFoundResponse({ description: ResponseDescription.NOT_FOUND })
  @ApiInternalServerErrorResponse({
    description: ResponseDescription.INTERNAL_SERVER_ERROR,
  })
  async findAccountById(
    @Param('accountId', ParseIntPipe) accountId: number,
  ): Promise<FindAccountByIdResponseDTO> {
    return this.queryBus.execute(new FindAccountByIdQuery(accountId));
  }
}
