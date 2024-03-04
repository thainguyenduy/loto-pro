import 'dart:ffi';

import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/contact/contact_values.dart';
import 'package:ld_app/src/domain/core/event.dart';
import 'package:ld_app/src/domain/core/i_entity.dart';
import 'package:ld_app/src/domain/core/value_objects/phone.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';
import 'package:ld_app/src/domain/core/value_object.dart';

part 'contact_failure.dart';
part 'contact_repository.dart';

enum ReplyModes {
  khongTraLoi,
  demTinNhanDaXuLyThanhCong,
  trichDanTinSauKhiXuLy,
  trichDanNoiDungNhanDuoc
}

extension ReplyModesExtension on ReplyModes {
  num get value {
    switch (this) {
      case ReplyModes.khongTraLoi:
        return 0;
      case ReplyModes.demTinNhanDaXuLyThanhCong:
        return 1;
      case ReplyModes.trichDanTinSauKhiXuLy:
        return 2;
      case ReplyModes.trichDanNoiDungNhanDuoc:
        return 3;
    }
  }
}

class Contact extends IEntity with DomainEvent {
  final String name;
  final Phone phone;
  final String chatId;
  final bool autoParse;
  ReplyMode replyMode;
  final String? contactAlias;
  final String? accountAlias;
  final String? telegramId;
  Contact(
      {required super.id,
      required this.name,
      required this.phone,
      required this.chatId,
      required this.autoParse,
      required this.replyMode,
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
      replyMode: ReplyMode(0),
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
    map['replyMode'] = replyMode.getOrCrash();
    map['contactAlias'] = contactAlias;
    map['accoutAlias'] = accountAlias;
    map['telegramId'] = telegramId;
    return map;
  }

  copyWith({required bool autoParse}) {}
}
