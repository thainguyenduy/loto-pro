import 'package:fpdart/fpdart.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ld_app/src/domain/contact/contact_values.dart';
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
  final bool isAutoParse;
  final ReplyMode replyMode;
  final DebtReminderMode debtReminderMode;
  final bool isLoCurrencyUnitAsThousandVND;
  final bool isDeCurrencyUnitAsThousandVND;
  final bool isRejectedOvertimeBet;
  final String? contactAlias;
  final String? accountAlias;
  final String? telegramId;
  Contact(
      {required super.id,
      required this.chatId,
      required this.phone,
      this.name = '',
      this.isAutoParse = true,
      this.replyMode = ReplyMode.khongTraLoi,
      this.debtReminderMode = DebtReminderMode.baoKemNoCuChiTiet,
      this.isLoCurrencyUnitAsThousandVND = true,
      this.isDeCurrencyUnitAsThousandVND = true,
      this.isRejectedOvertimeBet = true,
      this.contactAlias,
      this.accountAlias,
      this.telegramId});

  factory Contact.fromChat({required String chatId}) {
    return Contact(id: UniqueId(), phone: Phone(''), chatId: chatId);
  }

  @override
  Option<ValueFailure> get failureOption {
    return none();
  }

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
