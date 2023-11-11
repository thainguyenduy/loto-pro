import {
  Inject,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { IQueryHandler, QueryHandler } from '@nestjs/cqrs';

import { InjectionToken } from 'src/account/application/InjectionToken';
import { FindAccountByIdQuery } from 'src/account/application/query/FindAccountByIdQuery';
import { FindAccountByIdResult } from 'src/account/application/query/FindAccountByIdResult';

import { ErrorMessage } from 'src/account/domain/ErrorMessage';
import { IAccountQuery } from './IAccountQuery';
import { plainToInstance } from 'class-transformer';

@QueryHandler(FindAccountByIdQuery)
export class FindAccountByIdHandler
  implements IQueryHandler<FindAccountByIdQuery, FindAccountByIdResult>
{
  @Inject(InjectionToken.ACCOUNT_QUERY) readonly accountQuery: IAccountQuery;

  async execute(query: FindAccountByIdQuery): Promise<FindAccountByIdResult> {
    const data = await this.accountQuery.findById(query.id);
    if (!data) throw new NotFoundException(ErrorMessage.ACCOUNT_IS_NOT_FOUND);

    const result = plainToInstance(FindAccountByIdResult, data);
    return result;
  }
}
