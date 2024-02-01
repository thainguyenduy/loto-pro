import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ld_app/src/application/telegram_auth/telegram_authentication.dart';
import 'package:ld_app/src/domain/chat.dart';
import 'package:ld_app/src/domain/message.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/infrastructure/service/telegram_service.dart';
import 'package:tdlib/td_api.dart' as td;

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
  final TelegramService service = locator<TelegramService>();
  final _scaffold = GlobalKey<ScaffoldState>();
  final _displayChats = <Chat>[];
  final _searchController = TextEditingController();
  late StreamSubscription<td.TdObject> _eventsSubscription;
  List<Chat> _chats = [];

  void _write() {
    setState(() {
      _performSearch();
    });
  }

  void _performSearch() {
    final query = _searchController.text.toLowerCase();
    _displayChats.clear();
    if (query.isNotEmpty) {
      _displayChats.addAll(
          _chats.where((chat) => chat.title.toLowerCase().contains(query)));
    } else if (_chats.isNotEmpty) {
      _displayChats.addAll(_chats);
      _displayChats
          .sort((a, b) => b.messages.last.date.compareTo(a.messages.last.date));
    }
  }

  @override
  void initState() {
    super.initState();
    // _chats.add(savedMessages);
    _searchController.addListener(() => setState(() => _performSearch()));
    _getAllChats();
    _eventsSubscription = service.updates.listen(_onNewEvent);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _eventsSubscription.cancel();
    super.dispose();
  }

  void _onNewEvent(td.TdObject event) async {
    if (event is td.UpdateNewMessage) {
      print(event);
      _updateNewMessage(event.message);
    }
  }

  void _updateNewMessage(td.Message message) {
    Chat? chat;
    int index = -1;
    if (_chats.isNotEmpty) {
      index = _chats.indexWhere((chat) => chat.id == message.chatId);
    }
    if (index >= 0) {
      setState(() {
        chat = _chats[index];
        chat!.messages.add(TextMessage.fromTdlib(message, service.me!));
        _chats.removeAt(index);
        _chats.insert(0, chat!);
        _performSearch();
      });
    }
  }

  Future<void> _getAllChats() async {
    final chats = await service.getChats();
    setState(() {
      _chats.addAll(chats);
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
            if (_displayChats.isNotEmpty) ChatList(chats: _displayChats),
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
