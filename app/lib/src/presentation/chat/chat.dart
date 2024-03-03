import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ld_app/src/domain/chat.dart';
import 'package:ld_app/src/domain/message.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/infrastructure/service/telegram_service.dart';
import 'package:ld_app/src/presentation/components/utils.dart';
import 'package:ld_app/src/presentation/router/router.dart';
import 'package:tdlib/td_api.dart' as td;

import '../../domain/user.dart';
import '../components/bubbles.dart';
import '../components/chat_info_title.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({super.key, required this.chat});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? me;
  late final Chat chat = widget.chat;
  List<Message> messages = [];
  final _controller = TextEditingController();
  final TelegramService service = locator<TelegramService>();
  late StreamSubscription<td.TdObject> eventsSubscription;
  @override
  void initState() {
    super.initState();
    _getChatHistory();
    eventsSubscription = service.updates
        .where((event) =>
            event is td.UpdateNewMessage && event.message.chatId == chat.id)
        .listen(_onNewEvent);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNewEvent(td.TdObject event) async {
    _updateNewMessage((event as td.UpdateNewMessage).message);
  }

  void _updateNewMessage(td.Message message) {
    Message? msg = createMessageFactory(message, chat.title);

    setState(() {
      messages.add(msg!);
    });

    debugPrint('$message');
  }

  void _getChatHistory() async {
    me = locator<TelegramService>().me;

    List<Message> res = await service.getHistory(chat);
    setState(() {
      messages.addAll(res);
    });

    // final messages = await tdClient.send(td.GetMessageThreadHistory(chatId: _chatId, messageId: (chat.lastMessage as td.Message).id, fromMessageId: 0, offset: 99, limit: 30));
  }

  void _sendMessage(String text) async {
    if (text.isEmpty) {
      return;
    }
    final result = await service.sendMessage(chat.id, text);
    debugPrint('$result');
    setState(() {
      chat.sendMessage(me!, text);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: ChatInfoHeader(
          chat: chat,
          interactive: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              AutoRouter.of(context).push(ContactFormRoute());
            },
            tooltip: "Add this contact",
            icon: const Icon(Icons.person_add),
          ),
        ],
      ),
      body: messages.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, i) {
                      final currentMessage = messages[messages.length - i - 1];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: ChatMessageBubble(
                          message: currentMessage,
                          status: ChatMessageStatus.values[Random()
                              .nextInt(ChatMessageStatus.values.length)],
                          showSender: chat is GroupChat,
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
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
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
