import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_macos_app/views/auth/auth_routes.dart';
import 'package:my_macos_app/views/home/home_routes.dart';

class AppRouter {
  static void initialize({
    required String initialRoute,
  }) {
    AppRouter.initialRoute = initialRoute;
  }

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static late final String initialRoute;
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: initialRoute,
    routes: [AuthRoutes.login, HomeRoutes.home],
  );

  static String get currentPath {
    final BuildContext? ctx = navigatorKey.currentContext;
    if (ctx != null) {
      return GoRouter.of(ctx).routeInformationProvider.value.uri.path;
    }
    return initialRoute;
  }
}
