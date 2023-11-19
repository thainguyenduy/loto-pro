import 'dart:io';

import 'package:flutter/material.dart';
import 'package:telegram_client/telegram_client.dart';
import './src/app.dart';

void main() async {
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
  await tg.initIsolate();
  runApp(const MyApp());
}
