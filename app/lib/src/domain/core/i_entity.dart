import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';
import 'package:ld_app/src/domain/core/value_object.dart';

abstract interface class IEntity {
  UniqueId get id;
  Option<ValueFailure<dynamic>> get failureOption;
  Map<String, dynamic> toMap();
}
