import { IQueryResult } from '@nestjs/cqrs';

export class LoginAccountResult implements IQueryResult {
  constructor(
    readonly accessToken: string
  ) {}
}
