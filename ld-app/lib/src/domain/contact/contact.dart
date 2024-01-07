import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/core/i_entity.dart';
import 'package:ld_app/src/domain/value_objects/phone.dart';
import 'package:ld_app/src/domain/value_objects/value_failures.dart';
import 'package:ld_app/src/domain/core/value_object.dart';

class Contact implements IEntity {
  @override
  UniqueId id;
  String name;
  Phone phone;
  String telegramId;
  Contact(
      {required this.id,
      required this.name,
      required this.phone,
      required this.telegramId});

  @override
  // TODO: implement failureOption
  Option<ValueFailure> get failureOption {
    return none();
  }
}
