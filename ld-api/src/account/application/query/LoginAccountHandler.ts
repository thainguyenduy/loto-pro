import { IQueryHandler, QueryHandler } from '@nestjs/cqrs';
import { LoginAccountQuery } from './LoginAccountQuery';
import { LoginAccountResult } from './LoginAccountResult';
import { Inject, NotFoundException } from '@nestjs/common';
import { InjectionToken } from '../InjectionToken';
import { JwtService } from '@nestjs/jwt';
import { ErrorMessage } from 'src/account/domain/ErrorMessage';
import { IAccountQuery } from './IAccountQuery';

@QueryHandler(LoginAccountQuery)
export class LoginAccountHandler
  implements IQueryHandler<LoginAccountQuery, LoginAccountResult>
{
  @Inject(InjectionToken.ACCOUNT_QUERY) readonly accountQuery: IAccountQuery;
  @Inject() private jwtService: JwtService;
  async execute(query: LoginAccountQuery): Promise<LoginAccountResult> {
    const payload = await this.accountQuery.findOneByPhone(query.phone);
    if (!payload)
      throw new NotFoundException(ErrorMessage.ACCOUNT_IS_NOT_FOUND);

    const access_token = await this.jwtService.signAsync(payload);
    return new LoginAccountResult(access_token);
  }
}
