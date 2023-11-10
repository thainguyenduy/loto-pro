import { EventBus, IQueryHandler, QueryHandler } from '@nestjs/cqrs';
import { LoginAccountQuery } from './LoginAccountQuery';
import { LoginAccountResult } from './LoginAccountResult';
import { Inject, NotFoundException } from '@nestjs/common';
import { InjectionToken } from '../InjectionToken';
import { JwtService } from '@nestjs/jwt';
import { ErrorMessage } from 'src/account/domain/ErrorMessage';
import { IAccountQuery } from './IAccountQuery';
import { AccountDeviceChangedEvent } from 'src/account/domain/event/AccountDeviceChangedEvent';
import { Password, Phone } from 'libs/domain';

@QueryHandler(LoginAccountQuery)
export class LoginAccountHandler
  implements IQueryHandler<LoginAccountQuery, LoginAccountResult>
{
  @Inject() private eventBus: EventBus;
  @Inject(InjectionToken.ACCOUNT_QUERY) readonly accountQuery: IAccountQuery;
  @Inject() private jwtService: JwtService;
  async execute(query: LoginAccountQuery): Promise<LoginAccountResult> {
    const payload = await this.accountQuery.findOneByPhone(query.phone);
    if (!payload)
      throw new NotFoundException(ErrorMessage.ACCOUNT_IS_NOT_FOUND);
    const password = await Password.create({
      value: query.password,
      hashed: false,
    }).getHashedValue();
    if (payload.password != password) {
      throw new NotFoundException(ErrorMessage.ACCOUNT_IS_NOT_FOUND);
    }
    const access_token = await this.jwtService.signAsync(payload);
    this.eventBus.publish(
      new AccountDeviceChangedEvent(
        payload.accountId,
        payload.deviceId,
        Phone.create({ value: payload.phone }),
      ),
    );
    return new LoginAccountResult(access_token);
  }
}
