import { UnprocessableEntityException } from '@nestjs/common';
import { ValueObject } from './ValueObject';

export interface IPhoneProps {
  value: string;
}

export class Phone extends ValueObject<IPhoneProps> {
  get value(): any {
    return this.props.value;
  }
  public static phoneLength: number = 10;
  private static isValidPhone(phone: string) {
    const regex =
      /^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$/;
    return regex.test(phone);
  }
  public static create(props: IPhoneProps): Phone {
    if (!props.value)
      throw new UnprocessableEntityException(
        'Domain-ValueObject: Phone could not be empty!',
      );
    if (!Phone.isValidPhone(props.value))
      throw new UnprocessableEntityException(
        'Domain-ValueObject: Phone is not valid!',
      );
    return new Phone({
      value: props.value,
    });
  }
}
