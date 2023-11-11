import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsNumber } from 'class-validator';

export class FindAccountByIdRequestParam {
  @IsNumber()
  @ApiProperty({ example: 1 })
  @Type(() => Number)
  readonly accountId: number;
}
