// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDX7Xqdt6HYyQfhPVbEWRbCqKUnPitZJ-w',
    appId: '1:982975914156:android:c18a9d0c033d411360ff09',
    messagingSenderId: '982975914156',
    projectId: 'flutter-closegram',
    storageBucket: 'flutter-closegram.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQxV3EMgTWwJXfJZ9lqJdeDIOvR4r2sI4',
    appId: '1:982975914156:ios:76bf959b7d7a796b60ff09',
    messagingSenderId: '982975914156',
    projectId: 'flutter-closegram',
    storageBucket: 'flutter-closegram.appspot.com',
    iosClientId: '982975914156-qht22kp4pbobrc4lkd3uf5eqa0q837ku.apps.googleusercontent.com',
    iosBundleId: 'com.example.pesostagram',
  );
}
