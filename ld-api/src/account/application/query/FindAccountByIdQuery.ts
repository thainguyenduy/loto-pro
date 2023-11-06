import { IQuery } from '@nestjs/cqrs';

export interface IFindAccountByIdQuery extends IQuery {
  readonly id: string;
}
