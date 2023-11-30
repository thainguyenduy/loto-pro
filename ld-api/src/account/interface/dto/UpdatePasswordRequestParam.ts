import { ApiProperty } from '@nestjs/swagger';
import { IsNumber } from 'class-validator';
import { Id } from 'libs/domain';

export class UpdatePasswordRequestParam {
  @IsNumber()
  @ApiProperty({ example: Id.create() })
  readonly accountId: string;
}
