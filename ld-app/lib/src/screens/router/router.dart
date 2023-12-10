import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ld_app/src/application/app/app.dart';
import 'package:ld_app/src/screens/telegram/telegram_page.dart';
import 'package:ld_app/src/screens/telegram_home/telegram_home.dart';
import 'package:ld_app/src/screens/login/login_page.dart';
import 'package:ld_app/src/screens/telegram_sign_in/telegram_sign_in.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        //HomeScreen is generated as HomeRoute because
        //of the replaceInRouteName property
        AutoRoute(page: TelegramRoute.page),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        RedirectRoute(path: '*', redirectTo: '/'),
      ];
}

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [const MaterialPage(child: TelegramPage())];
    case AppStatus.unauthenticated:
      return [const MaterialPage(child: LoginPage())];
  }
}
