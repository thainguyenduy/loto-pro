import { EventBus, IQueryHandler, QueryHandler } from '@nestjs/cqrs';
import { LoginAccountQuery } from './LoginAccountQuery';
import { LoginAccountResult } from './LoginAccountResult';
import { BadRequestException, Inject, NotFoundException } from '@nestjs/common';
import { InjectionToken } from '../InjectionToken';
import { JwtService } from '@nestjs/jwt';
import { ErrorMessage } from 'src/account/domain/ErrorMessage';
import { IAccountQuery } from './IAccountQuery';
import { Id, Password, Phone } from 'libs/domain';
import { ConfigService } from '@nestjs/config';
import { AccountLoggedInEvent } from 'src/account/domain/event/AccountLoggedInEvent';

@QueryHandler(LoginAccountQuery)
export class LoginAccountHandler
  implements IQueryHandler<LoginAccountQuery, LoginAccountResult>
{
  @Inject() private eventBus: EventBus;
  @Inject(InjectionToken.ACCOUNT_QUERY) readonly accountQuery: IAccountQuery;
  @Inject() private jwtService: JwtService;
  @Inject() private configService: ConfigService;
  async execute(query: LoginAccountQuery): Promise<LoginAccountResult> {
    // TODO: Need refactor: khi tao tai khoan xong, dang nhap bang deviceId khac thi se bi loi.
    const payload = await this.accountQuery.findOneByPhone(query.phone);
    if (!payload)
      throw new NotFoundException(ErrorMessage.ACCOUNT_IS_NOT_FOUND);
    // Handle checking if account is activated
    const isActivated = payload.activated;
    if (!isActivated)
      throw new BadRequestException(ErrorMessage.ACCOUNT_IS_NOT_ACTIVATED);
    let numOfActiveDevice = 0;
    const devices = payload.devices;
    devices.forEach((device) => {
      if (device.active) numOfActiveDevice += 1;
    });

    // Handle number of logged in devices
    if (
      numOfActiveDevice >=
      this.configService.get<number>('MAX_ACTIVE_DEVICES_ALLOWED')
    )
      throw new BadRequestException(ErrorMessage.ACCOUNT_ALREADY_lOGGED_IN);

    const password = await Password.create({
      value: payload.password,
      hashed: true,
    });
    const same_password = await password.comparePassword(query.password);
    if (!same_password) {
      throw new NotFoundException(ErrorMessage.ACCOUNT_IS_NOT_FOUND);
    }
    const access_token = await this.jwtService.signAsync(
      { ...payload, deviceId: query.deviceId },
      {
        secret: this.configService.get<string>('SECRET_KEY'),
      },
    );
    this.eventBus.publish(
      // UPDATE CODE TRONG HANDLER UPDATE TRUONG ACTIVE bang device
      new AccountLoggedInEvent(
        Id.from(payload.accountId),
        query.deviceId,
        Phone.create({ value: payload.phone }),
      ),
    );
    return new LoginAccountResult(access_token);
  }
}
