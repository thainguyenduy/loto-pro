import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/value_objects/value_failures.dart';
import 'package:ld_app/src/domain/core/value_object.dart';

abstract class IEntity {
  UniqueId get id;
  Option<ValueFailure<dynamic>> get failureOption;
  Map<String, dynamic> toMap();
}
