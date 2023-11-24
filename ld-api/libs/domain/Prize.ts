import { UnprocessableEntityException } from '@nestjs/common/exceptions';
import { ValueObject } from './ValueObject';

export interface IPrizeProperties {
  value: string[];
}

abstract class Prize extends ValueObject<IPrizeProperties> {
  protected static readonly amount: number;
  protected static readonly len: number;
  get value(): string[] {
    return this.props.value;
  }
  protected static isValid(prizeResult: IPrizeProperties): boolean {
    if (prizeResult.value.length !== this.amount) return false;
    // trả về true nếu mọi phần tử đều là number và có độ dài bằng this.len
    return prizeResult.value.every(
      (v) => !isNaN(parseInt(v)) && v.toString().trim().length === this.len,
    );
  }
}

export class GiaiDacBiet extends Prize {
  public static readonly amount: number = 1;
  public static readonly len: number = 5;
  public static create(prize: IPrizeProperties): Prize {
    if (!this.isValid(prize)) {
      throw new UnprocessableEntityException(
        'Domain-ValueObject: invalid prize',
      );
    } else {
      return new GiaiDacBiet(prize);
    }
  }
}

export class GiaiNhat extends Prize {
  public static readonly amount: number = 1;
  public static readonly len: number = 5;
  public static create(prize: IPrizeProperties): Prize {
    if (!this.isValid(prize)) {
      throw new UnprocessableEntityException(
        'Domain-ValueObject: invalid prize',
      );
    } else {
      return new GiaiNhat(prize);
    }
  }
}

export class GiaiNhi extends Prize {
  public static readonly amount: number = 2;
  public static readonly len: number = 5;
  public static create(prize: IPrizeProperties): Prize {
    if (!this.isValid(prize)) {
      throw new UnprocessableEntityException(
        'Domain-ValueObject: invalid prize',
      );
    } else {
      return new GiaiNhi(prize);
    }
  }
}

export class GiaiBa extends Prize {
  public static readonly amount: number = 6;
  public static readonly len: number = 5;
  public static create(prize: IPrizeProperties): Prize {
    if (!this.isValid(prize)) {
      throw new UnprocessableEntityException(
        'Domain-ValueObject: invalid prize',
      );
    } else {
      return new GiaiBa(prize);
    }
  }
}

export class GiaiTu extends Prize {
  public static readonly amount: number = 4;
  public static readonly len: number = 4;
  public static create(prize: IPrizeProperties): Prize {
    if (!this.isValid(prize)) {
      throw new UnprocessableEntityException(
        'Domain-ValueObject: invalid prize',
      );
    } else {
      return new GiaiTu(prize);
    }
  }
}

export class GiaiNam extends Prize {
  public static readonly amount: number = 6;
  public static readonly len: number = 4;
  public static create(prize: IPrizeProperties): Prize {
    if (!this.isValid(prize)) {
      throw new UnprocessableEntityException(
        'Domain-ValueObject: invalid prize',
      );
    } else {
      return new GiaiNam(prize);
    }
  }
}

export class GiaiSau extends Prize {
  public static readonly amount: number = 3;
  public static readonly len: number = 3;
  public static create(prize: IPrizeProperties): Prize {
    if (!this.isValid(prize)) {
      throw new UnprocessableEntityException(
        'Domain-ValueObject: invalid prize',
      );
    } else {
      return new GiaiSau(prize);
    }
  }
}

export class GiaiBay extends Prize {
  public static readonly amount: number = 4;
  public static readonly len: number = 2;
  public static create(prize: IPrizeProperties): Prize {
    if (!this.isValid(prize)) {
      throw new UnprocessableEntityException(
        'Domain-ValueObject: invalid prize',
      );
    } else {
      return new GiaiBay(prize);
    }
  }
}
