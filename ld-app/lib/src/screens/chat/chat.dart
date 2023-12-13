import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ld_app/src/domain/chat.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:tdlib/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

import '../components/bubbles.dart';
import '../components/chat_info_title.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({
    super.key,
    required this.chat,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage(String text) async {
    if (text.isEmpty) {
      return;
    }
    final result = await locator<Client>().send(td.SendMessage(
        chatId: widget.chat.id,
        messageThreadId: 0,
        inputMessageContent: td.InputMessageText(
            text: td.FormattedText(text: text, entities: []),
            clearDraft: true)));
    print(result);
    setState(() {
      widget.chat.sendMessage(text);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: ChatInfoHeader(
          chat: widget.chat,
          interactive: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: widget.chat.messages.length,
              itemBuilder: (context, i) {
                final currentMessage =
                    widget.chat.messages[widget.chat.messages.length - i - 1];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ChatMessageBubble(
                    message: currentMessage,
                    status: ChatMessageStatus.values[
                        Random().nextInt(ChatMessageStatus.values.length)],
                    showSender: widget.chat is GroupChat,
                  ),
                );
              },
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: theme.secondaryHeaderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.symmetric(),
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {},
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(),
                      ),
                      minLines: 1,
                      maxLines: 5,
                      onSubmitted: _sendMessage,
                      autofocus: true,
                    ),
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.symmetric(),
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
