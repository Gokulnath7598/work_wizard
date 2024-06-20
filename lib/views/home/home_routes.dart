import 'package:go_router/go_router.dart';
import 'package:my_macos_app/views/home/home_page.dart';

class HomeRoutes {
  static GoRoute home = GoRoute(
    path: HomePage.routePath,
    builder: (context, state) {
      return const HomePage();
    },
  );
}
