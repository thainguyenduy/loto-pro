import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:ld_app/src/application/app/bloc/app_bloc.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/infrastructure/theme/theme.dart';
import 'package:ld_app/src/screens/router/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LD',
      debugShowCheckedModeBanner: false,
      theme: LDTheme.light,
      darkTheme: LDTheme.dark,
      home: FlowBuilder<AppStatus>(
        state: locator<AppBloc>().state.status,
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
