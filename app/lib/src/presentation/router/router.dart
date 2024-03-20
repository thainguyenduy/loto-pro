import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ld_app/src/presentation/app/bloc/app.dart';
import 'package:ld_app/src/domain/contact/contact.dart';
import 'package:ld_app/src/presentation/home/home_page.dart';
import 'package:ld_app/src/presentation/login/login_page.dart';
import 'package:ld_app/src/presentation/contact/contact_form_page.dart';
import 'package:ld_app/src/presentation/telegram/telegram_home/telegram_home.dart';
import 'package:ld_app/src/presentation/widgets/menu.dart';
import 'package:ld_app/src/presentation/telegram/telegram_sign_in/telegram_sign_in.dart';
part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        //HomeScreen is generated as HomeRoute because
        //of the replaceInRouteName property
        AutoRoute(page: HomeRoute.page, path: '/'),
        AutoRoute(page: TelegramHomeRoute.page),
        AutoRoute(page: LoginRoute.page),
        RedirectRoute(path: '*', redirectTo: '/'),
      ];
}

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [const MaterialPage(child: MenuPage())];
    case AppStatus.unauthenticated:
      return [const MaterialPage(child: LoginPage())];
  }
}
