import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ld_app/src/domain/chat.dart';

import 'direct_chat_info.dart';
import 'utils.dart';

class DirectChatInfoHeader extends StatelessWidget {
  final Chat chat;
  final bool interactive;

  const DirectChatInfoHeader({
    super.key,
    required this.chat,
    required this.interactive,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return InkWell(
      onTap: interactive
          ? () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DirectChatInfo(chat: chat)))
          : null,
      child: Row(
        children: [
          getChatAvatar(chat),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chat.title),
                Text(
                  chat is GroupChat
                      ? "${(chat as GroupChat).members.length} members"
                      : (random.nextBool() ? "online" : "last seen just now"),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
