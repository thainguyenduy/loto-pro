import { Entity } from 'src/core/domain/entities/Entity';
import { Password } from 'src/core/domain/value-objects/Password';
import { Phone } from 'src/core/domain/value-objects/Phone';

export type ContactEssentialProps = Readonly<
  Required<{
    id: string;
    phone: Phone;
  }>
>;

export type ContactOptionalProps = Readonly<
  Partial<{
    password: Password;
    lockedAt: Date | null;
    createdAt: Date;
    updatedAt: Date;
    deletedAt: Date | null;
    version: number;
  }>
>;

export interface IContact {}

export type ContactProps = ContactEssentialProps &
  Required<ContactOptionalProps>;

export class Contact extends Entity<ContactProps> implements IContact {}
