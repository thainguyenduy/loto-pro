// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    TelegramHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TelegramHomeScreen(),
      );
    },
    TelegramRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TelegramPage(),
      );
    },
    TelegramSignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TelegramSignInScreen(),
      );
    },
  };
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TelegramHomeScreen]
class TelegramHomeRoute extends PageRouteInfo<void> {
  const TelegramHomeRoute({List<PageRouteInfo>? children})
      : super(
          TelegramHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'TelegramHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TelegramPage]
class TelegramRoute extends PageRouteInfo<void> {
  const TelegramRoute({List<PageRouteInfo>? children})
      : super(
          TelegramRoute.name,
          initialChildren: children,
        );

  static const String name = 'TelegramRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TelegramSignInScreen]
class TelegramSignInRoute extends PageRouteInfo<void> {
  const TelegramSignInRoute({List<PageRouteInfo>? children})
      : super(
          TelegramSignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'TelegramSignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
