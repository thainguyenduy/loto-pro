import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';
import 'package:ld_app/src/domain/core/value_object.dart';

abstract class IEntity {
  IEntity({required this.id});
  UniqueId id;
  Option<ValueFailure<dynamic>> get failureOption;
  Map<String, dynamic> toMap();
}
