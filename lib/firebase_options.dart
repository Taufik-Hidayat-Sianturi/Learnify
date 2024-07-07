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
    apiKey: 'AIzaSyDFzUSelkgCFjYV7Hh1G2Q11iXRH0_qje4',
    appId: '1:685766104846:web:a1b27e01d9aa73d7c6a95f',
    messagingSenderId: '685766104846',
    projectId: 'learnify-bd33c',
    authDomain: 'learnify-bd33c.firebaseapp.com',
    storageBucket: 'learnify-bd33c.appspot.com',
    measurementId: 'G-DYEB4T63L4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDM16TUf8NRwIJsWwBnSwcDka47jrIQ7SE',
    appId: '1:685766104846:android:0f7f6a07cbd105c4c6a95f',
    messagingSenderId: '685766104846',
    projectId: 'learnify-bd33c',
    storageBucket: 'learnify-bd33c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwW0lbLrKAPskRffM2_-du0tnmBURx82Q',
    appId: '1:685766104846:ios:81a82da51f196d4ec6a95f',
    messagingSenderId: '685766104846',
    projectId: 'learnify-bd33c',
    storageBucket: 'learnify-bd33c.appspot.com',
    iosBundleId: 'com.example.learnify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwW0lbLrKAPskRffM2_-du0tnmBURx82Q',
    appId: '1:685766104846:ios:81a82da51f196d4ec6a95f',
    messagingSenderId: '685766104846',
    projectId: 'learnify-bd33c',
    storageBucket: 'learnify-bd33c.appspot.com',
    iosBundleId: 'com.example.learnify',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDFzUSelkgCFjYV7Hh1G2Q11iXRH0_qje4',
    appId: '1:685766104846:web:aa752195a55ed694c6a95f',
    messagingSenderId: '685766104846',
    projectId: 'learnify-bd33c',
    authDomain: 'learnify-bd33c.firebaseapp.com',
    storageBucket: 'learnify-bd33c.appspot.com',
    measurementId: 'G-WHJCK91TEE',
  );
}
