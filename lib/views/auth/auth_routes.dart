import 'package:go_router/go_router.dart';
import 'package:my_macos_app/views/auth/login_page.dart';

class AuthRoutes {
  static GoRoute login = GoRoute(
    path: LoginPage.routePath,
    builder: (context, state) {
      return const LoginPage();
    },
  );
}
