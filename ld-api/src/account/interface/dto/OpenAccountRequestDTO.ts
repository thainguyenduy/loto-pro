import { ApiProperty } from '@nestjs/swagger';
import {
  IsAlphanumeric,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';

export class OpenAccountRequestDTO {
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  @ApiProperty({ minLength: 10, maxLength: 10, example: '092' })
  readonly phone: string;

  @IsAlphanumeric()
  @ApiProperty({ example: '123345qwhdkjf' })
  readonly deviceId: string;

  @IsAlphanumeric()
  @MinLength(8)
  @MaxLength(20)
  @ApiProperty({ minLength: 8, maxLength: 20, example: 'password' })
  readonly password: string;
}
