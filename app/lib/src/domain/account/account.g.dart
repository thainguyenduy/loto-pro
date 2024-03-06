// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: const UniqueIdConverter().fromJson(json['id'] as String),
      deviceId: json['deviceId'] as String,
      telegramId: json['telegramId'] as String?,
      phone: const PhoneConverter().fromJson(json['phone'] as String),
      contacts: (json['contacts'] as List<dynamic>)
          .map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': const UniqueIdConverter().toJson(instance.id),
      'deviceId': instance.deviceId,
      'telegramId': instance.telegramId,
      'phone': const PhoneConverter().toJson(instance.phone),
      'contacts': instance.contacts,
    };
