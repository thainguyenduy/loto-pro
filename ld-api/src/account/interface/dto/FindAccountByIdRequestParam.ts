import { ApiProperty } from '@nestjs/swagger';
import { IsNumber } from 'class-validator';

import { EntityId } from 'libs/DatabaseModule';

export class FindAccountByIdRequestParam {
  @IsNumber()
  @ApiProperty({ example: new EntityId().toString() })
  readonly accountId: number;
}
