import { IQueryResult } from '@nestjs/cqrs';

export class FindAccountByIdResult implements IQueryResult {
  readonly id: string;
  readonly phone: string;
  readonly expirationDate: Date;
  readonly activated: boolean;
  readonly createdAt: Date;
  readonly updatedAt: Date;
  readonly deviceId: string | null;
}
