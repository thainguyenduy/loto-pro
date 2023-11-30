import { AggregateRoot } from '@nestjs/cqrs';
import { Id } from './Id';

const isEntity = (v: any): v is Entity<any> => {
  return v instanceof Entity;
};

export abstract class Entity<T> extends AggregateRoot {
  private readonly id: Id;
  constructor(props: T) {
    super();
    Object.assign(this, props);
  }

  get Id() {
    return this.id;
  }
  public equals(object?: Entity<T>): boolean {
    if (object == null || object == undefined) {
      return false;
    }

    if (this === object) {
      return true;
    }

    if (!isEntity(object)) {
      return false;
    }

    return this.id.equals(object.id);
  }
}
