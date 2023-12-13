import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:ld_app/src/domain/chat.dart';
import 'package:ld_app/src/domain/message.dart';
import 'package:ld_app/src/domain/user.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/screens/telegram/bloc/telegram_authentication_bloc.dart';
import 'package:tdlib/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

import '../../chat/chat.dart';
import '../../settings/menu.dart';
import '../../components/chat_list.dart';
import '../../components/search_chat_field.dart';

@RoutePage()
class TelegramHomeScreen extends StatefulWidget {
  const TelegramHomeScreen({super.key});

  @override
  State<TelegramHomeScreen> createState() => _TelegramHomeScreenState();
}

class _TelegramHomeScreenState extends State<TelegramHomeScreen> {
  // final _chats = List<Chat>.generate(4, (i) => _generateChat());
  static final _baseDate = DateTime.now().subtract(const Duration(days: 1));
  final _scaffold = GlobalKey<ScaffoldState>();
  final _displayChats = <Chat>[];
  final _searchController = TextEditingController();
  List<Chat> _chats = [];

  void _write() {
    setState(() {
      final newChat = _generateChat();
      _chats.add(newChat);
      _performSearch();
    });
  }

  void _performSearch() {
    final query = _searchController.text.toLowerCase();
    _displayChats.clear();
    if (query.isNotEmpty) {
      _displayChats.addAll(
          _chats.where((chat) => chat.title.toLowerCase().contains(query)));
    } else {
      _displayChats.addAll(_chats);
    }
    _displayChats
        .sort((a, b) => b.messages.last.date.compareTo(a.messages.last.date));
  }

  static final savedMessages = PrivateChat(
    id: User.me.id,
    title: 'Saved Messages',
    messages: List<Message>.generate(
      25,
      (i) => TextMessage(
        text: generateWordPairs()
            .take(Random().nextInt(3) + 1)
            .map((e) => e.join(' '))
            .join(' '),
        date: _baseDate.add(Duration(minutes: i)),
        sender: User.me,
      ),
    ),
    avatar: const Icon(
      Icons.bookmark,
      color: Colors.white,
    ),
  );

  static Chat _generateChat() {
    final random = Random();
    final baseDate = DateTime.now().subtract(const Duration(days: 1));
    if (1 == 1) {
      final members = List<User>.generate(
        random.nextInt(2047) + 1,
        (i) => User(
          id: random.nextInt(1 << 16),
          name: generateWordPairs().first.asPascalCase,
        ),
      );
      return GroupChat(
        id: random.nextInt(1 << 32),
        title: generateWordPairs().first.join(' '),
        messages: List<Message>.generate(
          random.nextInt(20) + 5,
          (i) {
            final date = baseDate.add(Duration(minutes: i));
            final sender = random.nextInt(3) == 0
                ? User.me
                : members[random.nextInt(members.length)];
            return random.nextBool()
                ? TextMessage(
                    text: generateWordPairs()
                        .take(random.nextInt(3) + 1)
                        .map((e) => e.join(' '))
                        .join(' '),
                    date: date,
                    sender: sender,
                  )
                : PhotoMessage(
                    date: date,
                    sender: sender,
                    photo:
                        "https://picsum.photos/seed/${random.nextInt(2048)}/512?random=$i",
                  );
          },
        ),
        members: members,
      );
    } else {
      final other = User(
        id: random.nextInt(1 << 16),
        name: generateWordPairs().first.asPascalCase,
      );
      return PrivateChat(
        id: other.id,
        title: other.name,
        messages: List<Message>.generate(
          random.nextInt(14) + 1,
          (i) {
            final date = baseDate.add(Duration(minutes: i));
            final sender = random.nextBool() ? User.me : other;
            return random.nextBool()
                ? TextMessage(
                    text: generateWordPairs()
                        .take(random.nextInt(3) + 1)
                        .map((e) => e.join(' '))
                        .join(' '),
                    date: date,
                    sender: sender,
                  )
                : PhotoMessage(
                    date: date,
                    sender: sender,
                    photo:
                        "https://picsum.photos/seed/${random.nextInt(2048)}/512?random=$i",
                  );
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // _chats.add(savedMessages);
    _searchController.addListener(() => setState(() => _performSearch()));
    _loadChats();
    _performSearch();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _loadChats() async {
    final tdClient = locator<Client>();
    final chatsList = await tdClient.send(const td.GetChats(limit: 100));
    if (chatsList is td.TdError) print(chatsList);
    List<int> chatIds = (chatsList as td.Chats).chatIds;
    List<td.Chat> messages = await Future.wait(
        chatIds.map((id) => tdClient.send(td.GetChat(chatId: id))));
    final _messages = messages.map((message) {
      return PrivateChat(id: message.id, title: message.title, messages: [
        TextMessage(
            date:
                DateTime.fromMillisecondsSinceEpoch(message.lastMessage!.date),
            sender: const User(id: 1, name: 'test'),
            text: message.lastMessage!.content.toString())
      ]);
    });
    setState(() {
      _chats = _messages.toList();
      _performSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      body: SafeArea(
        child: Stack(
          children: [
            ChatList(chats: _displayChats),
            SearchChatField(
                controller: _searchController, scaffoldKey: _scaffold),
          ],
        ),
      ),
      drawer: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 60, bottom: 8),
        child: Drawer(
          width: MediaQuery.of(context).size.width,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                child: Center(
                  child: Text("f-Telegram", style: TextStyle(fontSize: 24)),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.bookmark),
                title: const Text("Saved Messages+"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(chat: savedMessages),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Useless Settings"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsHomeScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () {
                  final telegramAuthBloc =
                      locator<TelegramAuthenticationBloc>();
                  telegramAuthBloc.add(const TelegramLogoutRequested());
                  Navigator.pop(context);
                  /* Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  ); */
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _write,
        tooltip: "Write a message",
        child: const Icon(Icons.edit),
      ),
    );
  }
}
