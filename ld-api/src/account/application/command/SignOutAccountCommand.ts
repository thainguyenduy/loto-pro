import { ICommand } from '@nestjs/cqrs';

export class SignOutAccountCommand implements ICommand {
  constructor(readonly accountId: number) {}
}
