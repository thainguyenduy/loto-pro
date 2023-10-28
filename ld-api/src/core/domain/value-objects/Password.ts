import * as bcrypt from 'bcrypt-nodejs';
import { ValueObject } from './ValueObject';
import { UnprocessableEntityException } from '@nestjs/common';

export interface IPasswordProps {
  value: string;
  hashed?: boolean;
}

export class Password extends ValueObject<IPasswordProps> {
  public static minLength: number = 6;

  get value(): string {
    return this.props.value;
  }

  private static isAppropriateLength(password: string): boolean {
    return password.length >= this.minLength;
  }

  /**
   * @method comparePassword
   * @desc Compares as plain-text and hashed password.
   */

  public async comparePassword(plainTextPassword: string): Promise<boolean> {
    let hashed: string;
    if (this.isAlreadyHashed()) {
      hashed = this.props.value;
      return this.bcryptCompare(plainTextPassword, hashed);
    } else {
      return this.props.value === plainTextPassword;
    }
  }

  private bcryptCompare(plainText: string, hashed: string): Promise<boolean> {
    return new Promise((resolve, reject) => {
      bcrypt.compare(plainText, hashed, (err, compareResult) => {
        if (err) return resolve(false);
        return resolve(compareResult);
      });
    });
  }

  public isAlreadyHashed(): boolean {
    return this.props.hashed;
  }

  private hashPassword(password: string): Promise<string> {
    return new Promise((resolve, reject) => {
      bcrypt.hash(password, null, null, (err, hash) => {
        if (err) return reject(err);
        resolve(hash);
      });
    });
  }

  public getHashedValue(): Promise<string> {
    return new Promise((resolve) => {
      if (this.isAlreadyHashed()) {
        return resolve(this.props.value);
      } else {
        return resolve(this.hashPassword(this.props.value));
      }
    });
  }

  public static create(props: IPasswordProps): Password {
    if (!props.value) {
      throw new UnprocessableEntityException(
        'Domain-ValueObject: Password could not be empty!',
      );
    }
    if (!props.hashed) {
      if (!this.isAppropriateLength(props.value)) {
        throw new UnprocessableEntityException(
          `Domain-ValueObject: Password doesnt meet criteria [${Password.minLength} chars min].`,
        );
      }
    }

    return new Password({
      value: props.value,
      hashed: !!props.hashed === true,
    });
  }
}
