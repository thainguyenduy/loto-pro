// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      id: const UniqueIdConverter().fromJson(json['id'] as String),
      chatId: json['chatId'] as String,
      phone: const PhoneConverter().fromJson(json['phone'] as String),
      name: json['name'] as String? ?? '',
      autoParse: json['autoParse'] as bool? ?? true,
      replyMode: $enumDecodeNullable(_$ReplyModeEnumMap, json['replyMode']) ??
          ReplyMode.khongTraLoi,
      debtReminderMode: $enumDecodeNullable(
              _$DebtReminderModeEnumMap, json['debtReminderMode']) ??
          DebtReminderMode.baoKemNoCuChiTiet,
      loCurrencyUnitAsThousandVND:
          json['loCurrencyUnitAsThousandVND'] as bool? ?? true,
      deCurrencyUnitAsThousandVND:
          json['deCurrencyUnitAsThousandVND'] as bool? ?? true,
      rejectedOvertimeBet: json['rejectedOvertimeBet'] as bool? ?? true,
      contactAlias: json['contactAlias'] as String?,
      accountAlias: json['accountAlias'] as String?,
      telegramId: json['telegramId'] as String?,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'id': const UniqueIdConverter().toJson(instance.id),
      'name': instance.name,
      'phone': const PhoneConverter().toJson(instance.phone),
      'chatId': instance.chatId,
      'autoParse': instance.autoParse,
      'replyMode': _$ReplyModeEnumMap[instance.replyMode]!,
      'debtReminderMode': _$DebtReminderModeEnumMap[instance.debtReminderMode]!,
      'loCurrencyUnitAsThousandVND': instance.loCurrencyUnitAsThousandVND,
      'deCurrencyUnitAsThousandVND': instance.deCurrencyUnitAsThousandVND,
      'rejectedOvertimeBet': instance.rejectedOvertimeBet,
      'contactAlias': instance.contactAlias,
      'accountAlias': instance.accountAlias,
      'telegramId': instance.telegramId,
    };

const _$ReplyModeEnumMap = {
  ReplyMode.khongTraLoi: 0,
  ReplyMode.demTinNhanDaXuLyThanhCong: 1,
  ReplyMode.trichDanTinSauKhiXuLy: 2,
  ReplyMode.trichDanNoiDungNhanDuoc: 3,
  ReplyMode.khongXacDinh: -1,
};

const _$DebtReminderModeEnumMap = {
  DebtReminderMode.baoKemNoCuChiTiet: 0,
  DebtReminderMode.khongXacDinh: -1,
};
