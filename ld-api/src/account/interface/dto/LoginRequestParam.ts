import { ApiProperty } from '@nestjs/swagger';
import { IsAlphanumeric, Length, MaxLength, MinLength } from 'class-validator';

export class LoginRequestParamDTO {
  @ApiProperty({ example: '0912345678', minLength: 10, maxLength: 10 })
  readonly phone: string;

  @IsAlphanumeric()
  @MinLength(8)
  @MaxLength(20)
  @ApiProperty({ minLength: 8, maxLength: 20, example: 'password' })
  readonly password: string;

  @IsAlphanumeric()
  @Length(32, 32)
  readonly deviceId: string;
}
