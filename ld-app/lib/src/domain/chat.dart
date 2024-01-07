import 'package:flutter/widgets.dart';
import 'package:ld_app/src/presentation/components/utils.dart';
import 'package:tdlib/td_api.dart' as td;

import './message.dart';
import './user.dart';

enum ChatType {
  group,
  private,
}

abstract class Chat {
  final int id;
  final String title;
  final ChatType type;
  final List<Message> messages;
  final Widget? avatar;

  const Chat({
    required this.id,
    required this.title,
    required this.type,
    required this.messages,
    this.avatar,
  });

  sendMessage(User sender, String text) {
    final message = TextMessage(
      text: text,
      date: DateTime.now(),
      sender: sender,
    );
    messages.add(message);
  }

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is Chat && id == other.id && type == other.type;

  @override
  int get hashCode => id.hashCode ^ type.hashCode;
}

class PrivateChat extends Chat {
  const PrivateChat({
    required super.id,
    required super.title,
    required super.messages,
    super.avatar,
  }) : super(type: ChatType.private);
  factory PrivateChat.fromTdlib(td.Chat chat, User me) {
    List<Message> messages = [];
    messages.add(createMessageFactory(chat.lastMessage!, chat.title)!);

    return PrivateChat(
        id: chat.id, title: chat.title, messages: messages.toList());
  }
}

class GroupChat extends Chat {
  final List<User> members;

  const GroupChat({
    required super.id,
    required super.title,
    required super.messages,
    super.avatar,
    required this.members,
  }) : super(type: ChatType.group);
}
