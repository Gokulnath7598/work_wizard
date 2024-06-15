import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  static const platform = MethodChannel('overlay_channel');

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter macOS Overlay Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                platform.invokeMethod('showOverlay');
              },
              child: const Text('Show Overlay'),
            ),
            ElevatedButton(
              onPressed: () {
                platform.invokeMethod('closeOverlay');
              },
              child: const Text('Close Overlay'),
            ),
          ],
        ),
      ),
    );
  }
}
