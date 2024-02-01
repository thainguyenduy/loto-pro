import { IQuery } from '@nestjs/cqrs';

export class LoginAccountQuery implements IQuery {
  constructor(
    readonly phone: string,
    readonly password: string,
    readonly deviceId: string,
  ) {}
}
