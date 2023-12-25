import 'package:tdlib/td_api.dart' as td;

import './user.dart';

abstract class Message {
  final DateTime date;
  final User sender;

  const Message({
    required this.date,
    required this.sender,
  });
}

class TextMessage extends Message {
  final String text;

  const TextMessage({
    required super.date,
    required super.sender,
    required this.text,
  });
  factory TextMessage.fromTdlib(td.Message message, String senderName) {
    return TextMessage(
        date: DateTime.fromMillisecondsSinceEpoch(message.date),
        sender: User(
            id: (message.senderId as td.MessageSenderUser).userId,
            name: senderName),
        text: (message.content as td.MessageText).text.text);
  }
}

class PhotoMessage extends Message {
  final String photo;

  const PhotoMessage({
    required super.date,
    required super.sender,
    required this.photo,
  });
}
