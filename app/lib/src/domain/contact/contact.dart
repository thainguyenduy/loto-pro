import 'dart:ffi';

import 'package:fpdart/fpdart.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ld_app/src/domain/contact/contact_values.dart';
import 'package:ld_app/src/domain/core/event.dart';
import 'package:ld_app/src/domain/core/i_entity.dart';
import 'package:ld_app/src/domain/core/value_objects/phone.dart';
import 'package:ld_app/src/domain/core/value_objects/unique_id.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';

part 'contact_failure.dart';
part 'contact_repository.dart';
part 'contact.g.dart';

@JsonSerializable()
class Contact extends IEntity {
  final String name;
  @PhoneConverter()
  final Phone phone;
  final String chatId;
  final bool autoParse;
  ReplyMode replyMode;
  DebtReminderMode debtReminderMode;
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
      required this.debtReminderMode,
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
        replyMode: ReplyMode.khongTraLoi,
        debtReminderMode: DebtReminderMode.baoKemNoCuChiTiet);
  }

  @override
  Option<ValueFailure> get failureOption {
    return none();
  }

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
