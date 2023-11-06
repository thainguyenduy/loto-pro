import { ApiProperty } from '@nestjs/swagger';

import { EntityId } from 'libs/DatabaseModule';

import { FindAccountsResult } from 'src/account/application/query/FindAccountsResult';

class Account {
  @ApiProperty({ example: new EntityId() })
  readonly id: string;

  @ApiProperty({ example: '0912345678' })
  readonly phone: string;

  @ApiProperty({ example: '01-01-2099 23:59:59' })
  readonly expirationDate: Date;

  @ApiProperty({ example: true })
  readonly activated: boolean;
}

export class FindAccountsResponseDto extends FindAccountsResult {
  @ApiProperty({ type: [Account] })
  readonly accounts: Account[];
}
