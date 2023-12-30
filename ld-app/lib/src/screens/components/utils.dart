import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ld_app/src/domain/chat.dart';
import 'package:ld_app/src/domain/message.dart';
import 'package:ld_app/src/domain/user.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/infrastructure/service/telegram_service.dart';
import 'package:tdlib/td_api.dart' as td;

const _colors = [
  Color(0xffe17076),
  Color(0xffeda86c),
  Color(0xffa695e7),
  Color(0xff7bc862),
  Color(0xff6ec9cb),
  Color(0xff65aadd),
  Color(0xffee7aae),
]; // taken from official app

Color getColorByID(int id) => _colors[id % _colors.length];

Widget getChatAvatar(Chat chat) => CircleAvatar(
      backgroundColor: getColorByID(chat.id),
      child: chat.avatar ??
          Text(
            chat.title.isNotEmpty ? chat.title[0].toUpperCase() : "D",
            style: const TextStyle(color: Colors.white),
          ),
    );

Widget getUserAvatar(User? user) => user != null
    ? CircleAvatar(
        backgroundColor: getColorByID(user.id),
        child: Text(
          user.name[0].toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      )
    : const CircularProgressIndicator();

String telegramFormatDate(DateTime dateToCheck) {
  List<String> weekdays = [
    'Thứ hai',
    'Thứ ba',
    'Thứ tư',
    'Thứ năm',
    'Thứ sáu',
    'Thứ bảy',
    'Chủ nhật'
  ];
  final aDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  int daysSinceMonday = (now.weekday - 1) % 7;
  DateTime monday = today.subtract(Duration(days: daysSinceMonday));
  if (dateToCheck.isBefore(monday)) {
    return '${dateToCheck.day}/${dateToCheck.month}';
  } else if (dateToCheck.isBefore(today)) {
    return weekdays[aDate.weekday - 1];
  } else {
    return DateFormat.Hm().format(dateToCheck);
  }
}

Message? createMessageFactory(td.Message message, String senderName) {
  User me = locator<TelegramService>().me!;
  User sender =
      (me.id == (message.senderId as td.MessageSenderUser).userId)
          ? me
          : User(
              id: (message.senderId as td.MessageSenderUser).userId,
              name: senderName);
  if (message.content is td.MessageText) {
    return TextMessage.fromTdlib(message, sender);
  } else if (message.content is td.MessagePhoto) {
    return PhotoMessage.fromTdlib(message, sender);
  } else if (message.content is td.MessageSticker) {
    return StickerMessage.fromTdlib(message, sender);
  } else {
    return null;
  }
}
