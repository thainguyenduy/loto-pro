import { ApiProperty } from '@nestjs/swagger';
import { IsAlphanumeric } from 'class-validator';

export class LoginRequestResponseDTO {
  @IsAlphanumeric()
  @ApiProperty({ example: '091234asdsadf' })
  readonly accessToken: string;
}
