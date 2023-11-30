import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ld_app/src/application/app/bloc/app_bloc.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/infrastructure/theme/theme.dart';
import 'package:ld_app/src/screens/router/router.dart';
import 'package:ld_app/src/screens/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<AppBloc>(),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LD',
      debugShowCheckedModeBanner: false,
      theme: LDTheme.light,
      darkTheme: LDTheme.dark,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
