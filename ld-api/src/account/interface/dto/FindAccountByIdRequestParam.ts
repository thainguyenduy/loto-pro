import { ApiProperty } from '@nestjs/swagger';
import { IsAlphanumeric } from 'class-validator';

import { EntityId } from 'libs/DatabaseModule';

export class FindAccountByIdRequestParam {
  @IsAlphanumeric()
  @ApiProperty({ example: new EntityId().toString() })
  readonly accountId: string;
}
