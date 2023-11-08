import { IQueryHandler, QueryHandler } from '@nestjs/cqrs';
import { LoginAccountQuery } from './LoginAccountQuery';
import { LoginAccountResult } from './LoginAccountResult';
import { Inject } from '@nestjs/common';
import { InjectionToken } from '../InjectionToken';

@QueryHandler(LoginAccountQuery)
export class LoginAccountHandler
  implements IQueryHandler<LoginAccountQuery, LoginAccountResult>
{
  @Inject(InjectionToken.ACCOUNT_QUERY) readonly accountQuery: IAccountQuery;
  @Inject() private jwtService: JwtService;
  async execute(query: LoginAccountQuery): Promise<LoginAccountResult> {
    const data = await this.accountQuery.findOneByPhone(query);
    if (!data) throw new NotFoundException(ErrorMessage.ACCOUNT_IS_NOT_FOUND);

    const payload = {
      id: data.accountId,
      phone: data.phone,
      deviceId: data.deviceId,
    };
    const access_token = await this.jwtService.signAsync(payload);
    return new LoginAccountResult(access_token);
  }
}
