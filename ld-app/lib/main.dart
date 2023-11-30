import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ld_app/src/application/app/app.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/screens/app.dart';
import 'package:telegram_client/telegram_client.dart';
import 'src/screens/app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  var path = Directory.current.path;
  Tdlib tg = Tdlib(clientOption: {
    'api_id': 23305343,
    'api_hash': '65b8c22115224d72ed65c5290d687975',
    'database_directory': "$path/user/",
    'files_directory': "$path/user/",
  });
  tg.on("update", (UpdateTd update) {
    print(update.raw);
  });
  tg.request("sendMessage",
      parameters: {"chat_id": 4067410070, "text": "Hello world"});
  await tg.initIsolate();
  await configureDependencies(environment: 'dev');
  runApp(const App());
}
