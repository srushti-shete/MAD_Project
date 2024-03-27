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
    apiKey: 'AIzaSyCwy2sPY7oFOCqifZNZjYMlsVaeGpl0aw8',
    appId: '1:407925551732:web:5df9d0c9089b2b45719721',
    messagingSenderId: '407925551732',
    projectId: 'nashamukti-app',
    authDomain: 'nashamukti-app.firebaseapp.com',
    storageBucket: 'nashamukti-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCA7AWrGMfz18YA7a1WvpgGsj3HD0N2uI',
    appId: '1:407925551732:android:2f1b1a565c3f2a67719721',
    messagingSenderId: '407925551732',
    projectId: 'nashamukti-app',
    storageBucket: 'nashamukti-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASb0BVrATfuSdYZuTOIiXERB4tsOex4-I',
    appId: '1:407925551732:ios:940979007531ff15719721',
    messagingSenderId: '407925551732',
    projectId: 'nashamukti-app',
    storageBucket: 'nashamukti-app.appspot.com',
    iosBundleId: 'com.example.modernlogintute',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASb0BVrATfuSdYZuTOIiXERB4tsOex4-I',
    appId: '1:407925551732:ios:940979007531ff15719721',
    messagingSenderId: '407925551732',
    projectId: 'nashamukti-app',
    storageBucket: 'nashamukti-app.appspot.com',
    iosBundleId: 'com.example.modernlogintute',
  );
}
