import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:my_macos_app/api_service/api_service.dart';
import 'package:my_macos_app/core/app_router/app_router.dart';
import 'package:my_macos_app/core/base_bloc/base_bloc.dart';
import 'package:my_macos_app/firebase_options.dart';
import 'package:my_macos_app/preferences_client/preferences_client.dart';
import 'package:my_macos_app/views/auth/login_page.dart';
import 'package:my_macos_app/views/home/home_page.dart';

import 'models/models.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PreferencesClient.initialize();
  ApiService.initialize();

  final AppUser? user = PreferencesClient.getUser();

  AppRouter.initialize(
    initialRoute: user == null ? LoginPage.routePath : HomePage.routePath,
  );

  Bloc.observer = AppBlocObserver();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MacosApp.router(
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
