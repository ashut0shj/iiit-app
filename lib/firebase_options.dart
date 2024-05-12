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
    apiKey: 'AIzaSyDZysmCE51dLQKbs9wdOg2s74Ddxnv3TqI',
    appId: '1:781305780908:web:560ec26715e56271185d09',
    messagingSenderId: '781305780908',
    projectId: 'iiitapp',
    authDomain: 'iiitapp.firebaseapp.com',
    databaseURL: 'https://iiitapp-default-rtdb.firebaseio.com',
    storageBucket: 'iiitapp.appspot.com',
    measurementId: 'G-D2FEP0ZPVN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBX3Hf5hQ5ACBhtHSiCCBVFVd-o744kKGY',
    appId: '1:781305780908:android:f5ff5421021c7a5a185d09',
    messagingSenderId: '781305780908',
    projectId: 'iiitapp',
    databaseURL: 'https://iiitapp-default-rtdb.firebaseio.com',
    storageBucket: 'iiitapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3TtOio0bLGoFJiTV5SuDKSogJDYMo6FE',
    appId: '1:781305780908:ios:aebd3de8ef2d4677185d09',
    messagingSenderId: '781305780908',
    projectId: 'iiitapp',
    databaseURL: 'https://iiitapp-default-rtdb.firebaseio.com',
    storageBucket: 'iiitapp.appspot.com',
    iosBundleId: 'com.example.iiitnr',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3TtOio0bLGoFJiTV5SuDKSogJDYMo6FE',
    appId: '1:781305780908:ios:aebd3de8ef2d4677185d09',
    messagingSenderId: '781305780908',
    projectId: 'iiitapp',
    databaseURL: 'https://iiitapp-default-rtdb.firebaseio.com',
    storageBucket: 'iiitapp.appspot.com',
    iosBundleId: 'com.example.iiitnr',
  );
}
