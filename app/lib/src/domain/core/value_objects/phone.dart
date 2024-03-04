import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/core/value_object.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';

class Phone extends ValueObject<String, ValueFailure<String>> {
  @override
  final Either<ValueFailure<String>, String> value;
  const Phone._(this.value);
  factory Phone(String input) {
    return Phone._(validatePhone(input));
  }
  static Either<ValueFailure<String>, String> validatePhone(String input) {
    final RegExp regex = RegExp(r'(84|0[3|5|7|8|9])+([0-9]{8})\b');
    return regex.hasMatch(input) ? right(input) : left(InvalidPhone(input));
  }
}
