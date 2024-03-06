import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import 'package:ld_app/src/domain/core/errors.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';

abstract class IValidatable {
  bool isValid();
}

@immutable
abstract class ValueObject<T, K extends ValueFailure> implements IValidatable {
  const ValueObject();
  Either<K, T> get value;

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    return value.fold((f) => throw UnexpectedValueError(f), identity);
  }

  T getOrElse(T dflt) {
    return value.getOrElse((l) => dflt);
  }

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold(
      (l) => left(l),
      (r) => right(unit),
    );
  }

  @override
  bool isValid() {
    return value.isRight();
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObject<T, K> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}
