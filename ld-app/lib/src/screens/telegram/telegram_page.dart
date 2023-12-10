import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ld_app/src/application/telegram_authentication/telegram_authentication_bloc.dart';
import 'package:ld_app/src/screens/splash/splash_page.dart';
import 'package:ld_app/src/screens/telegram_home/telegram_home.dart';

@RoutePage()
class TelegramPage extends StatelessWidget {
  const TelegramPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TelegramAuthenticationBloc, TelegramAuthState>(
        builder: (context, state) {
      if (state.status == TelegramAuthStatus.success) {
        return const TelegramHomeScreen();
      } else if (state.status == TelegramAuthStatus.failure) {
        return const TelegramHomeScreen();
      } else {
        return const SplashPage();
      }
    });
  }
}
