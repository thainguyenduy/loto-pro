import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:tdlib/td_api.dart' as td_api;
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/screens/app.dart';
import 'package:tdlib/tdlib.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  var path = Directory.current.path;
  final tdlibPath =
      (Platform.isAndroid || Platform.isLinux || Platform.isWindows)
          ? 'libtdjson.so'
          : null;
  await TdPlugin.initialize(tdlibPath);
  int clientId = tdCreate();
  tdSend(
      clientId,
      td_api.SetTdlibParameters(
          useMessageDatabase: true,
          useSecretChats: true,
          apiId: 23305343,
          apiHash: '65b8c22115224d72ed65c5290d687975',
          systemLanguageCode: 'en',
          deviceModel: 'Device Model',
          systemVersion: 'System Version',
          applicationVersion: '1.0',
          enableStorageOptimizer: true,
          useTestDc: true,
          databaseDirectory: "${path}user/",
          filesDirectory: "${path}user/",
          useFileDatabase: true,
          ignoreFileNames: true,
          useChatInfoDatabase: true,
          databaseEncryptionKey: 'test123'));
  final state = tdReceive();
  if (state is td_api.AuthorizationStateWaitPhoneNumber) {
    // Handle phone number input
    print(state);
  } else if (state is td_api.AuthorizationStateWaitCode) {
    print(state);
    // Handle code input
  } else if (state is td_api.AuthorizationStateReady) {
    print(state);
    // Handle successful authorization
  }
  await configureDependencies(environment: 'dev');
  runApp(const App());
}
