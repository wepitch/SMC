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
    apiKey: 'AIzaSyD2NH9RFK-ShmoS8DW6w8eBGjNfEgamOdM',
    appId: '1:469856705592:web:872a8340acbe676cc19acd',
    messagingSenderId: '469856705592',
    projectId: 'sort-my-college',
    authDomain: 'sort-my-college.firebaseapp.com',
    storageBucket: 'sort-my-college.appspot.com',
    measurementId: 'G-KF673MK5T8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDY3Ii5SzHDzbUe-dtqkCu9VnnLxQsBTGo',
    appId: '1:469856705592:android:62abd4054977322cc19acd',
    messagingSenderId: '469856705592',
    projectId: 'sort-my-college',
    storageBucket: 'sort-my-college.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCzm5U-B8qCaHLGOY7Ohzd_25xJGEP-iM4',
    appId: '1:469856705592:ios:deee61c67a508cbdc19acd',
    messagingSenderId: '469856705592',
    projectId: 'sort-my-college',
    storageBucket: 'sort-my-college.appspot.com',
    iosBundleId: 'com.example.test',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCzm5U-B8qCaHLGOY7Ohzd_25xJGEP-iM4',
    appId: '1:469856705592:ios:4679d14691b0b372c19acd',
    messagingSenderId: '469856705592',
    projectId: 'sort-my-college',
    storageBucket: 'sort-my-college.appspot.com',
    iosBundleId: 'com.sortmycollege',
  );
}
