import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:ld_app/src/domain/chat.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tdlib/td_client.dart';

import '../../domain/user.dart';

class TelegramService {
  final Client client;
  TelegramService(this.client);
  /* static TelegramService create(Client client) {
    client.initialize();
    TelegramService service = TelegramService._(client);
    return service;
  } */

  Stream<td.TdObject> get updates => client.updates;

  Future<td.TdObject> setTdlibParameters() async {
    return await client.send(
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

  Future<User> get me async {
    /* final res = await client.send(const td.GetMe());
    return User.me(res as td.User); */
    return const User(id: 1, name: 'test');
  }

  Future<td.TdObject> setAuthenticationPhoneNumber(String phone) async {
    return await client
        .send(td.SetAuthenticationPhoneNumber(phoneNumber: phone));
  }

  Future<td.TdObject> checkAuthenticationCode(String code) async {
    return await client.send(td.CheckAuthenticationCode(code: code));
  }

  Future<td.TdObject> checkAuthenticationPassword(String password) async {
    return await client
        .send(td.CheckAuthenticationPassword(password: password));
  }

  Future<td.TdObject> logOut() async {
    return await client.send(const td.LogOut());
  }

  Future<List<Chat>> getChats() async {
    final chatsList = await client.send(const td.LoadChats(limit: 100));
    if (chatsList is td.TdError) print(chatsList);
    List<int> chatIds = (chatsList as td.Chats).chatIds;
    List<td.Chat> chats = await Future.wait(
        chatIds.map((id) => client.send(td.GetChat(chatId: id))));
    return chats.where((chat) {
      return (chat.lastMessage!.content is td.MessageText ||
          // message.lastMessage!.content is td.MessagePhoto ||
          chat.lastMessage!.content is td.MessageAnimatedEmoji);
    }).map((chat) {
      return PrivateChat.fromTdlib(chat);
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
