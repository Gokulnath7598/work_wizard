import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:my_macos_app/api_service/api_service.dart';
import 'package:my_macos_app/preferences_client/preferences_client.dart';
import 'package:my_macos_app/views/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesClient.initialize();
  ApiService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MacosApp(
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const LoginPage(),
    );
  }
}
