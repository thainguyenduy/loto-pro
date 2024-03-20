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
    ContactFormRoute.name: (routeData) {
      final args = routeData.argsAs<ContactFormRouteArgs>(
          orElse: () => const ContactFormRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ContactFormPage(
          key: args.key,
          chatId: args.chatId,
          contact: args.contact,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    MenuRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MenuPage(),
      );
    },
    TelegramHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TelegramHomeScreen(),
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
/// [ContactFormPage]
class ContactFormRoute extends PageRouteInfo<ContactFormRouteArgs> {
  ContactFormRoute({
    Key? key,
    String? chatId,
    Contact? contact,
    List<PageRouteInfo>? children,
  }) : super(
          ContactFormRoute.name,
          args: ContactFormRouteArgs(
            key: key,
            chatId: chatId,
            contact: contact,
          ),
          initialChildren: children,
        );

  static const String name = 'ContactFormRoute';

  static const PageInfo<ContactFormRouteArgs> page =
      PageInfo<ContactFormRouteArgs>(name);
}

class ContactFormRouteArgs {
  const ContactFormRouteArgs({
    this.key,
    this.chatId,
    this.contact,
  });

  final Key? key;

  final String? chatId;

  final Contact? contact;

  @override
  String toString() {
    return 'ContactFormRouteArgs{key: $key, chatId: $chatId, contact: $contact}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [MenuPage]
class MenuRoute extends PageRouteInfo<void> {
  const MenuRoute({List<PageRouteInfo>? children})
      : super(
          MenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuRoute';

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
