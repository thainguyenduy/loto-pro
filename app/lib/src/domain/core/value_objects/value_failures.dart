sealed class ValueFailure<T> {}

class ShortPassword extends ValueFailure<String> {
  String failedValue;
  ShortPassword(this.failedValue);
}

class InvalidPhone extends ValueFailure<String> {
  String invalidPhone;
  InvalidPhone(this.invalidPhone);
}

class ValueEnteredNotMatch<T> extends ValueFailure {
  T failedValue;
  ValueEnteredNotMatch(this.failedValue);
}

var l = InvalidPhone('wife');
var t = switch (l) { InvalidPhone() => 'Số điện thoại không đúng' };
