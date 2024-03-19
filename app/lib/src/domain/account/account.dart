import 'package:fpdart/fpdart.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ld_app/src/domain/account/events/contact_added_event.dart';
import 'package:ld_app/src/domain/contact/contact.dart';
import 'package:ld_app/src/domain/core/i_entity.dart';
import 'package:ld_app/src/domain/core/value_objects/phone.dart';
import 'package:ld_app/src/domain/core/value_objects/unique_id.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';

part 'account_failure.dart';
part 'account_repository.dart';
part 'account.g.dart';

@JsonSerializable()
class Account extends IEntity {
  String deviceId;
  String? telegramId;
  @PhoneConverter()
  Phone phone;
  List<Contact> contacts;

  Account(
      {required super.id,
      required this.deviceId,
      this.telegramId,
      required this.phone,
      required this.contacts});

  @override
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
      id: UniqueId(),
      deviceId: deviceId,
      phone: phone,
      contacts: [],
    );
  }

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
