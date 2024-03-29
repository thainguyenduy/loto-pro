import { ApiProperty } from '@nestjs/swagger';

import { FindAccountByIdResult } from 'src/account/application/query/FindAccountByIdResult';

export class FindAccountByIdResponseDto extends FindAccountByIdResult {
  @ApiProperty({ example: 1 })
  readonly id: string;

  @ApiProperty({ example: '0912345678', minLength: 10, maxLength: 10 })
  readonly phone: string;

  @ApiProperty()
  readonly createdAt: Date;

  @ApiProperty()
  readonly updatedAt: Date;

  @ApiProperty({ nullable: true, example: null })
  readonly deviceId: string | null;
}
