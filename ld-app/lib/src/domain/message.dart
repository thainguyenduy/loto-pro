import 'package:tdlib/td_api.dart' as td;

import './user.dart';

abstract class Message {
  final DateTime date;
  final User sender;

  const Message({
    required this.date,
    required this.sender,
  });
  String get content;
  bool get outgoing => sender.me == true;
}

class TextMessage extends Message {
  final String text;

  const TextMessage({
    required super.date,
    required super.sender,
    required this.text,
  });
  factory TextMessage.fromTdlib(td.Message message, User sender) {
    return TextMessage(
        date: DateTime.fromMillisecondsSinceEpoch(message.date * 1000),
        sender: sender,
        text: (message.content as td.MessageText).text.text);
  }
  @override
  String get content {
    return text;
  }
}

class PhotoMessage extends Message {
  final String photo;

  const PhotoMessage({
    required super.date,
    required super.sender,
    required this.photo,
  });
  factory PhotoMessage.fromTdlib(td.Message message, User sender) {
    return PhotoMessage(
        date: DateTime.fromMillisecondsSinceEpoch(message.date * 1000),
        sender: sender,
        photo: (message.content as td.MessagePhoto).photo.minithumbnail!.data);
  }
  @override
  String get content {
    return '<photo>';
  }
}

class StickerMessage extends Message {
  final String sticker;

  const StickerMessage({
    required super.date,
    required super.sender,
    required this.sticker,
  });
  factory StickerMessage.fromTdlib(td.Message message, User sender) {
    return StickerMessage(
        date: DateTime.fromMillisecondsSinceEpoch(message.date * 1000),
        sender: sender,
        sticker: (message.content as td.MessageSticker).sticker.emoji);
  }
  @override
  String get content {
    return sticker;
  }
}
