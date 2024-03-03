import 'dart:ffi';

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
  Phone phone;
  String chatId;
  bool autoParse;
  String? contactAlias;
  String? accountAlias;
  String? telegramId;
  Contact(
      {required super.id,
      required this.name,
      required this.phone,
      required this.chatId,
      required this.autoParse,
      this.contactAlias,
      this.accountAlias,
      this.telegramId});

  factory Contact.fromChat({required String chatId}) {
    return Contact(
      id: UniqueId(),
      name: '',
      phone: Phone(''),
      chatId: chatId,
      autoParse: false,
    );
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
    map['phone'] = phone.getOrCrash();
    map['chatId'] = chatId;
    map['autoParse'] = autoParse;
    map['contactAlias'] = contactAlias;
    map['accoutAlias'] = accountAlias;
    map['telegramId'] = telegramId;
    return map;
  }

  copyWith({required bool autoParse}) {}
}
