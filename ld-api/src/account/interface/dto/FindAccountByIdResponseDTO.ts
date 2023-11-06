import { ApiProperty } from '@nestjs/swagger';

import { EntityId } from 'libs/DatabaseModule';

import { FindAccountByIdResult } from 'src/account/application/query/FindAccountByIdResult';

export class FindAccountByIdResponseDTO extends FindAccountByIdResult {
  @ApiProperty({ example: new EntityId() })
  readonly id: string;

  @ApiProperty({ example: '0912345678', minLength: 10, maxLength: 10 })
  readonly phone: string;

  @ApiProperty({ example: 100 })
  readonly balance: number;

  @ApiProperty()
  readonly createdAt: Date;

  @ApiProperty()
  readonly updatedAt: Date;

  @ApiProperty({ nullable: true, example: null })
  readonly deviceId: string | null;
}
