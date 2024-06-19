// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBQnmr2rtrSGTVxLqKxpVQInHkUkgW4gTo',
    appId: '1:1045502999827:web:9134c5e50d3df733d9aee6',
    messagingSenderId: '1045502999827',
    projectId: 'work-wizard-bf979',
    authDomain: 'work-wizard-bf979.firebaseapp.com',
    storageBucket: 'work-wizard-bf979.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuudYE6B0FpHibnTYGZbMc9wrNia2mOvs',
    appId: '1:1045502999827:android:19958bce143b223ad9aee6',
    messagingSenderId: '1045502999827',
    projectId: 'work-wizard-bf979',
    storageBucket: 'work-wizard-bf979.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlljKDZi73ahs2Wlfmrp-t7P1Lp1htPHU',
    appId: '1:1045502999827:ios:8e55d3718ac6808fd9aee6',
    messagingSenderId: '1045502999827',
    projectId: 'work-wizard-bf979',
    storageBucket: 'work-wizard-bf979.appspot.com',
    iosBundleId: 'com.example.myMacosApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDlljKDZi73ahs2Wlfmrp-t7P1Lp1htPHU',
    appId: '1:1045502999827:ios:8e55d3718ac6808fd9aee6',
    messagingSenderId: '1045502999827',
    projectId: 'work-wizard-bf979',
    storageBucket: 'work-wizard-bf979.appspot.com',
    iosBundleId: 'com.example.myMacosApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBQnmr2rtrSGTVxLqKxpVQInHkUkgW4gTo',
    appId: '1:1045502999827:web:f826e83e55b1b1c6d9aee6',
    messagingSenderId: '1045502999827',
    projectId: 'work-wizard-bf979',
    authDomain: 'work-wizard-bf979.firebaseapp.com',
    storageBucket: 'work-wizard-bf979.appspot.com',
  );
}
