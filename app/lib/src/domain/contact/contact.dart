import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/core/i_entity.dart';
import 'package:ld_app/src/domain/core/value_objects/phone.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';
import 'package:ld_app/src/domain/core/value_object.dart';

class Contact implements IEntity {
  @override
  UniqueId id;
  String name;
  String contactAlias;
  String accountAlias;
  Phone phone;
  String telegramId;
  Contact(
      {required this.id,
      required this.name,
      required this.contactAlias,
      required this.accountAlias,
      required this.phone,
      required this.telegramId});

  factory Contact.create(
      {required String name,
      required String contactAlias,
      required String accountAlias,
      required Phone phone,
      required String telegramId}) {
    return Contact(
        id: UniqueId(),
        name: name,
        contactAlias: contactAlias,
        accountAlias: accountAlias,
        phone: phone,
        telegramId: telegramId);
  }

  @override
  Option<ValueFailure> get failureOption {
    return none();
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id.getOrCrash();
    map['name'] = name;
    map['contactAlias'] = contactAlias;
    map['accoutAlias'] = accountAlias;
    map['phone'] = phone.getOrCrash();
    map['telegramId'] = telegramId;
    return map;
  }
}
