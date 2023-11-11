import { ApiProperty } from '@nestjs/swagger';
import { IsNumber } from 'class-validator';

export class UpdatePasswordRequestParam {
  @IsNumber()
  @ApiProperty({ example: 2345234 })
  readonly accountId: number;
}
