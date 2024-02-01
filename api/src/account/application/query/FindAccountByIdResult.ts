import { IQueryResult } from '@nestjs/cqrs';
import { Exclude } from 'class-transformer';

export class FindAccountByIdResult implements IQueryResult {
  public readonly id: string;
  public readonly phone: string;
  public readonly expirationDate: Date;
  public readonly activated: boolean;
  public readonly createdAt: Date;
  public readonly updatedAt: Date;
  public readonly deviceId: string | null;
  @Exclude()
  public readonly password: string;
}
