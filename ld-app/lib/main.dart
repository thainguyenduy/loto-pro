import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/screens/app/app.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  await configureDependencies(environment: 'dev');
  runApp(const App());
}
