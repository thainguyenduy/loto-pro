import { ApiProperty } from '@nestjs/swagger';
import {
  IsAlphanumeric,
  IsString,
  MaxLength,
  MinLength,
  Length,
} from 'class-validator';

export class OpenAccountRequestDTO {
  @IsString()
  @Length(10, 10)
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
