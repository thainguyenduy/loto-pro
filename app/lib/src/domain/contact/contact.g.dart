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
      isAutoParse: json['isAutoParse'] as bool? ?? true,
      replyMode: $enumDecodeNullable(_$ReplyModeEnumMap, json['replyMode']) ??
          ReplyMode.khongTraLoi,
      debtReminderMode: $enumDecodeNullable(
              _$DebtReminderModeEnumMap, json['debtReminderMode']) ??
          DebtReminderMode.baoKemNoCuChiTiet,
      isLoCurrencyUnitAsThousandVND:
          json['isLoCurrencyUnitAsThousandVND'] as bool? ?? true,
      isDeCurrencyUnitAsThousandVND:
          json['isDeCurrencyUnitAsThousandVND'] as bool? ?? true,
      isRejectedOvertimeBet: json['isRejectedOvertimeBet'] as bool? ?? true,
      contactAlias: json['contactAlias'] as String?,
      accountAlias: json['accountAlias'] as String?,
      telegramId: json['telegramId'] as String?,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'id': const UniqueIdConverter().toJson(instance.id),
      'name': instance.name,
      'phone': const PhoneConverter().toJson(instance.phone),
      'chatId': instance.chatId,
      'isAutoParse': instance.isAutoParse,
      'replyMode': _$ReplyModeEnumMap[instance.replyMode]!,
      'debtReminderMode': _$DebtReminderModeEnumMap[instance.debtReminderMode]!,
      'isLoCurrencyUnitAsThousandVND': instance.isLoCurrencyUnitAsThousandVND,
      'isDeCurrencyUnitAsThousandVND': instance.isDeCurrencyUnitAsThousandVND,
      'isRejectedOvertimeBet': instance.isRejectedOvertimeBet,
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
