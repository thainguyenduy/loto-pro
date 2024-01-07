import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ld_app/src/application/app/app.dart';
import 'package:ld_app/src/application/telegram_auth/telegram_authentication.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/presentation/splash/splash_page.dart';
import 'package:ld_app/src/presentation/telegram/telegram_home/telegram_home.dart';
import 'package:ld_app/src/presentation/telegram/telegram_sign_in/telegram_sign_in.dart';

@RoutePage()
class TelegramPage extends StatelessWidget {
  const TelegramPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => locator<TelegramAuthenticationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Menu',
          ),
          backgroundColor: const Color(0xff764abc),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Danh mục'),
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text('Đăng xuất'),
                onTap: () {
                  final appBloc = locator<AppBloc>();
                  appBloc.add(const AppLogoutRequested());
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        body: BlocBuilder<TelegramAuthenticationBloc, TelegramAuthState>(
            builder: (context, state) {
          if ([
            TelegramAuthStatus.success,
          ].contains(state.status)) {
            return const TelegramHomeScreen();
          } else if ([
            TelegramAuthStatus.waitPhoneNumber,
            TelegramAuthStatus.waitCode,
            TelegramAuthStatus.waitPassword,
            TelegramAuthStatus.failure,
            TelegramAuthStatus.loggedOut,
          ].contains(state.status)) {
            return const TelegramSignInScreen();
          } else {
            return const SplashPage();
          }
        }),
      ),
    );
  }
}
