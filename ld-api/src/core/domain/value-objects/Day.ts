import { UnprocessableEntityException } from '@nestjs/common/exceptions';
import { ValueObject } from './ValueObject';

export interface DayProperties {
  value: string;
}

export class Day extends ValueObject<DayProperties> {
  isValid: (props: DayProperties) => boolean;
  get value(): string {
    return this.props.value;
  }
  private constructor(props: DayProperties) {
    super(props);
  }

  private static isValidDay(day: string) {
    const re =
      /^(3[01]|[12][0-9]|0?[1-9])(\/|-)(1[0-2]|0?[1-9])\2([0-9]{2})?[0-9]{2}$/;
    return re.test(day);
  }
  public static create(day: string): Day {
    if (!this.isValidDay(day)) {
      throw new UnprocessableEntityException('Domain-ValueObject: invalid day');
    } else {
      return new Day({ value: day.trim() });
    }
  }
}
