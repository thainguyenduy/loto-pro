import 'package:fpdart/fpdart.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';
import 'package:ld_app/src/domain/core/value_object.dart';

class Password extends ValueObject<String, ValueFailure<String>> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value);
  static Either<ValueFailure<String>, String> validatePassword(String input) {
    // You can also add some advanced password checks (uppercase/lowercase, at least 1 number, ...)
    if (input.length >= 6) {
      return right(input);
    } else {
      return left(ShortPassword(input));
    }
  }
}

class PasswordConverter implements JsonConverter<Password, String> {
  const PasswordConverter();

  @override
  Password fromJson(String password) => Password(password);

  @override
  String toJson(Password password) => password.getOrCrash();
}
