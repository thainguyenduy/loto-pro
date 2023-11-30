import { v4 } from 'uuid';
import { ValueObject } from './ValueObject';

export interface IdProperties {
  value: string;
}

export class Id extends ValueObject<IdProperties> {
  public static create(): Id {
    return new Id({ value: v4().split('-').join('') });
  }
  public static from(id: string) {
    return new Id({ value: id });
  }
}
