import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_macos_app/api_service/api_service.dart';
import 'package:my_macos_app/base_bloc/base_bloc.dart';
import 'package:my_macos_app/blocs/app_bloc/app_bloc.dart';
import 'package:my_macos_app/blocs/timeline/timeline_bloc.dart';
import 'package:my_macos_app/core/app_router/app_router.dart';
import 'package:my_macos_app/preferences_client/preferences_client.dart';
import 'package:my_macos_app/views/auth/login_page.dart';
import 'package:my_macos_app/views/home/home_page.dart';

import 'models/models.dart';

class OverlayController {
  static const platform = MethodChannel('overlay_channel');
  static Timer? timer;

  static void startOverlayTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      platform.invokeMethod('showOverlay');
    });
  }

  static void stopOverlayTimer() {
    timer?.cancel();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesClient.initialize();
  ApiService.initialize();

  final AppUser? user = PreferencesClient.getUser();

  AppRouter.initialize(
    // initialRoute: user == null ? LoginPage.routePath : HomePage.routePath,
    initialRoute: LoginPage.routePath,
  );

  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TimeLineBloc>(create: (BuildContext context) => TimeLineBloc()),
        BlocProvider(
          create: (context) => AppBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    OverlayController.stopOverlayTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MacosApp.router(
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.system,
      // home: const LoginPage(),
      routerConfig: AppRouter.router,
    );
  }
}
