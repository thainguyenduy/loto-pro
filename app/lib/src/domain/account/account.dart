import 'package:event_bus/event_bus.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/account/events/contact_added_event.dart';
import 'package:ld_app/src/domain/contact/contact.dart';
import 'package:ld_app/src/domain/core/event.dart';
import 'package:ld_app/src/domain/core/i_entity.dart';
import 'package:ld_app/src/domain/value_objects/phone.dart';
import 'package:ld_app/src/domain/value_objects/value_failures.dart';
import 'package:ld_app/src/domain/core/value_object.dart';

part 'account_exception.dart';
part 'account_repository.dart';

class Account with DomainEvent implements IEntity {
  @override
  UniqueId id;
  String deviceId;
  String? telegramId;
  Phone phone;
  List<Contact> contacts;

  Account(
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

  addContact(Contact contact) {
    eventBus.fire(ContactAddedEvent());
  }

  removeContact(String contactId) {
    eventBus.fire(ContactAddedEvent());
  }

  factory Account.create({required String deviceId, required Phone phone}) {
    return Account(
        id: UniqueId(), deviceId: deviceId, phone: phone, contacts: []);
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id.getOrCrash();
    map['deviceId'] = deviceId;
    if (telegramId != null) map['telegramId'] = telegramId;
    map['phone'] = phone.getOrCrash();
    if (contacts.isNotEmpty) {
      map['contacts'] = contacts.map((contact) => contact.toMap());
    }
    return map;
  }
}