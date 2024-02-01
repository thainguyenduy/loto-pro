import { Inject } from '@nestjs/common';
import { IQueryHandler, QueryHandler } from '@nestjs/cqrs';

import { InjectionToken } from 'src/account/application/InjectionToken';
import { FindAccountsQuery } from 'src/account/application/query/FindAccountsQuery';
import { FindAccountsResult } from 'src/account/application/query/FindAccountsResult';
import { IAccountQuery } from './IAccountQuery';

@QueryHandler(FindAccountsQuery)
export class FindAccountsHandler
  implements IQueryHandler<FindAccountsQuery, FindAccountsResult>
{
  @Inject(InjectionToken.ACCOUNT_QUERY) readonly accountQuery: IAccountQuery;

  async execute(query: FindAccountsQuery): Promise<FindAccountsResult> {
    return this.accountQuery.findByPhone(query);
  }
}
