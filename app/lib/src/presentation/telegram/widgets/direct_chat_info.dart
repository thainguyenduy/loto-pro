import 'package:flutter/material.dart';
import 'package:ld_app/src/domain/chat.dart';

import 'direct_chat_info_header.dart';
import 'utils.dart';

class DirectChatInfo extends StatefulWidget {
  final Chat chat;

  const DirectChatInfo({
    super.key,
    required this.chat,
  });

  @override
  State<DirectChatInfo> createState() => _DirectChatInfoState();
}

class _DirectChatInfoState extends State<DirectChatInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DirectChatInfoHeader(
          chat: widget.chat,
          interactive: false,
        ),
      ),
      body: widget.chat is GroupChat
          ? ListView.builder(
              itemCount: (widget.chat as GroupChat).members.length,
              itemBuilder: (context, i) {
                final currentMember = (widget.chat as GroupChat).members[i];
                return ListTile(
                  leading: getUserAvatar(currentMember),
                  title: Text(currentMember.name),
                  onTap: () {
                    final messenger = ScaffoldMessenger.of(context);
                    messenger.clearSnackBars();
                    messenger.showSnackBar(SnackBar(
                      content: Text(
                          "Clicked on ${currentMember.name} (${currentMember.id})"),
                      duration: const Duration(seconds: 1),
                    ));
                  },
                );
              },
            )
          : ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.badge),
                  title: const Text("ID"),
                  subtitle: Text(widget.chat.id.toString()),
                )
              ],
            ),
    );
  }
}
