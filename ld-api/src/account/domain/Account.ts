import { UnprocessableEntityException } from '@nestjs/common';
import { Contact } from 'src/contact/domain/Contact';
import { Entity } from 'src/core/domain/entities/Entity';
import { Password } from 'src/core/domain/value-objects/Password';

export type AccountEssentialProps = Readonly<
  Required<{
    id: string;
    imei: string;
    password: Password;
  }>
>;

export type AccountOptionalProps = Readonly<
  Partial<{
    contacts: Contact[];
    lockedAt: Date | null;
    createdAt: Date;
    updatedAt: Date;
    deletedAt: Date | null;
    version: number;
  }>
>;

export type AccountProps = AccountEssentialProps &
  Required<AccountOptionalProps>;

export interface IAccount {
  getId: string;
  open: () => void;
  close: () => void;
  updatePassword: (password: string) => void;
  lock: () => void;
}

export class Account extends Entity<AccountProps> implements IAccount {
  private password: Password;
  private contacts: Contact[];
  private lockedAt: Date | null;
  private readonly createdAt: Date;
  private updatedAt: Date;
  private deletedAt: Date | null;
  private version;

  constructor(props: AccountProps) {
    super(props);
  }
  get getId() {
    return this.id;
  }
  updatePassword(password: string): void {
    this.password = Password.create({ value: password, hashed: true });
    this.updatedAt = new Date();
  }

  close(): void {}
  open(): void {}

  lock(): void {
    if (this.lockedAt)
      throw new UnprocessableEntityException('Account is already locked');
    this.lockedAt = new Date();
    this.updatedAt = new Date();
    this.version += 1;
  }
}
