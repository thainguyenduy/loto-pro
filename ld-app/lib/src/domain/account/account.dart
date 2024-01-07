import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/contact/contact.dart';
import 'package:ld_app/src/domain/core/i_entity.dart';
import 'package:ld_app/src/domain/value_objects/phone.dart';
import 'package:ld_app/src/domain/value_objects/value_failures.dart';
import 'package:ld_app/src/domain/core/value_object.dart';

abstract interface class IAccount extends IEntity {
  addContact(Contact contact);
  removeContact(String contactId);
}

class Account implements IAccount {
  @override
  UniqueId id;
  String deviceId;
  String? telegramId;
  Phone phone;
  List<Contact> contacts;

  Account._(
      {required this.id,
      required this.deviceId,
      this.telegramId,
      required this.phone,
      required this.contacts});

  @override
  // TODO: implement failureOption
  Option<ValueFailure> get failureOption {
    return none();
  }

  @override
  addContact(Contact contact) {
    // TODO: implement addContact
    throw UnimplementedError();
  }

  @override
  removeContact(String contactId) {
    // TODO: implement removeContact
    throw UnimplementedError();
  }

  factory Account.create({required String deviceId, required Phone phone}) {
    return Account._(
        id: UniqueId(), deviceId: deviceId, phone: phone, contacts: []);
  }
}
