// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCmPlLU5XqlPouZ9Gewt11LvIjoTEQIRJI',
    appId: '1:542848168172:web:a5a74b225289a0a336f5c9',
    messagingSenderId: '542848168172',
    projectId: 'dam-u4-proyec1',
    authDomain: 'dam-u4-proyec1.firebaseapp.com',
    storageBucket: 'dam-u4-proyec1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYmmlVZ4zwSj4EWfhmgq9AlumgMls1P24',
    appId: '1:542848168172:android:6284907cf699b6c236f5c9',
    messagingSenderId: '542848168172',
    projectId: 'dam-u4-proyec1',
    storageBucket: 'dam-u4-proyec1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcvZ9wMAQlrKfBooom1jO4F0S5KCFZxIM',
    appId: '1:542848168172:ios:684e278ee8e35c8c36f5c9',
    messagingSenderId: '542848168172',
    projectId: 'dam-u4-proyec1',
    storageBucket: 'dam-u4-proyec1.appspot.com',
    iosClientId: '542848168172-qlht26bhbp7s0l9ldtafe8msac9i729c.apps.googleusercontent.com',
    iosBundleId: 'com.example.damU4Pro119400568',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDcvZ9wMAQlrKfBooom1jO4F0S5KCFZxIM',
    appId: '1:542848168172:ios:684e278ee8e35c8c36f5c9',
    messagingSenderId: '542848168172',
    projectId: 'dam-u4-proyec1',
    storageBucket: 'dam-u4-proyec1.appspot.com',
    iosClientId: '542848168172-qlht26bhbp7s0l9ldtafe8msac9i729c.apps.googleusercontent.com',
    iosBundleId: 'com.example.damU4Pro119400568',
  );
}
