import 'package:flutter/material.dart';
import 'package:ld_app/src/domain/chat.dart';

import '../chat/chat.dart';
import 'utils.dart';

class ChatList extends StatelessWidget {
  final List<Chat> chats;

  const ChatList({
    super.key,
    required this.chats,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 60),
      itemCount: chats.length,
      itemBuilder: (context, i) {
        final currentChat = chats[i];
        return ChatListTile(chat: currentChat);
      },
    );
  }
}

class ChatListTile extends StatelessWidget {
  final Chat chat;

  const ChatListTile({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final lastMessage = chat.messages.last;
    return ListTile(
      leading: getChatAvatar(chat),
      title: Text(chat.title.isNotEmpty ? chat.title : "Deleted Account",
          style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(
        lastMessage.content,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        telegramFormatDate(chat.messages.last.date),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(chat: chat),
          ),
        );
      },
    );
  }
}
