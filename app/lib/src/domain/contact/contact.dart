import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/core/event.dart';
import 'package:ld_app/src/domain/core/i_entity.dart';
import 'package:ld_app/src/domain/core/value_objects/phone.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';
import 'package:ld_app/src/domain/core/value_object.dart';

part 'contact_failure.dart';
part 'contact_repository.dart';

class Contact extends IEntity with DomainEvent {
  String name;
  String contactAlias;
  String accountAlias;
  Phone phone;
  String? telegramId;
  String chatId;
  Contact(
      {required super.id,
      required this.name,
      required this.contactAlias,
      required this.accountAlias,
      required this.phone,
      required this.chatId,
      this.telegramId});

  factory Contact.fromChat({required String chatId}) {
    return Contact(
        id: UniqueId(),
        name: '',
        contactAlias: '',
        accountAlias: '',
        phone: Phone(''),
        telegramId: '',
        chatId: chatId);
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
