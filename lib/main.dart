import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  static const platform = const MethodChannel('overlay_channel');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter macOS Overlay Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                platform.invokeMethod('showOverlay');
              },
              child: Text('Show Overlay'),
            ),
            ElevatedButton(
              onPressed: () {
                platform.invokeMethod('closeOverlay');
              },
              child: Text('Close Overlay'),
            ),
          ],
        ),
      ),
    );
  }
}
