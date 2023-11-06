import { ICommand } from '@nestjs/cqrs';

export class OpenAccountCommand implements ICommand {
  constructor(
    readonly phone: string,
    readonly password: string,
    readonly deviceId: string,
  ) {}
}
