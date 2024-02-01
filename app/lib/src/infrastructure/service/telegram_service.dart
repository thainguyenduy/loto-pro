import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:ld_app/src/domain/chat.dart';
import 'package:ld_app/src/domain/message.dart';
import 'package:ld_app/src/presentation/components/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tdlib/td_client.dart';

import '../../domain/user.dart';

class TelegramService {
  final Client _client;
  User? me;
  TelegramService._(this._client);

  @FactoryMethod()
  static TelegramService create(Client client) {
    client.initialize();
    return TelegramService._(client);
  }

  Stream<td.TdObject> get updates => _client.updates;

  Future<td.TdObject> setTdlibParameters() async {
    return await _client.send(
      td.SetTdlibParameters(
        systemVersion: '',
        useTestDc: false,
        useSecretChats: false,
        useMessageDatabase: true,
        useFileDatabase: true,
        useChatInfoDatabase: true,
        ignoreFileNames: true,
        enableStorageOptimizer: true,
        filesDirectory: await _getFilesDirectory(),
        databaseDirectory: await _getDatabaseDirectory(),
        systemLanguageCode: 'en',
        deviceModel: 'unknown',
        applicationVersion: '1.0.0',
        apiId: 23305343,
        apiHash: '65b8c22115224d72ed65c5290d687975',
        databaseEncryptionKey: '',
      ),
    );
  }

  Future<void> getMe() async {
    final res = await _client.send(const td.GetMe());
    me = User.me(res as td.User);
    // return const User(id: 1, name: 'test');
  }

  Future sendMessage(int chatId, String text) async {
    return await _client.send(td.SendMessage(
        chatId: chatId,
        messageThreadId: 0,
        inputMessageContent: td.InputMessageText(
            text: td.FormattedText(text: text, entities: const []),
            clearDraft: true)));
  }

  Future<List<Message>> getHistory(Chat chat) async {
    td.Messages messages = await _client.send(td.GetChatHistory(
        chatId: chat.id,
        fromMessageId: 0,
        offset: 0,
        limit: 99,
        onlyLocal: false));
    return (messages.messages != null && messages.messages!.isNotEmpty)
        ? messages.messages!.map((td.Message message) {
            return createMessageFactory(message, chat.title)!;
          }).toList()
        : [];
  }

  Future<td.TdObject> setAuthenticationPhoneNumber(String phone) async {
    return await _client
        .send(td.SetAuthenticationPhoneNumber(phoneNumber: phone));
  }

  Future<td.TdObject> checkAuthenticationCode(String code) async {
    return await _client.send(td.CheckAuthenticationCode(code: code));
  }

  Future<td.TdObject> checkAuthenticationPassword(String password) async {
    return await _client
        .send(td.CheckAuthenticationPassword(password: password));
  }

  Future<td.TdObject> logOut() async {
    return await _client.send(const td.LogOut());
  }

  Future<List<Chat>> getChats() async {
    final chatsList = await _client.send(const td.GetChats(limit: 100));
    if (chatsList is td.TdError) print(chatsList);
    List<int> chatIds = (chatsList as td.Chats).chatIds;
    List<td.Chat> chats = await Future.wait(
        chatIds.map((id) => _client.send(td.GetChat(chatId: id))));
    return chats.where((chat) {
      return chat.type is td.ChatTypePrivate &&
          (chat.lastMessage!.content is td.MessageText ||
              chat.lastMessage!.content is td.MessagePhoto ||
              chat.lastMessage!.content is td.MessageSticker);
    }).map((chat) {
      return PrivateChat.fromTdlib(chat, me!);
    }).toList();
  }

  static Future<String> _getFilesDirectory() async {
    if (kIsWeb) {
      return 'files';
    }
    final Directory applicationSupportDirectory =
        await getApplicationSupportDirectory();

    return '${applicationSupportDirectory.path}/files';
  }

  static Future<String> _getDatabaseDirectory() async {
    if (kIsWeb) {
      return 'database';
    }
    final Directory applicationSupportDirectory =
        await getApplicationSupportDirectory();

    return '${applicationSupportDirectory.path}/database';
  }
}
