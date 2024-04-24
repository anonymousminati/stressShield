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
    apiKey: 'AIzaSyDQ_XSu4TVbS3Xn__DaqdTxp70OPKamcfY',
    appId: '1:192727806596:web:b304375ce11293ea0908d1',
    messagingSenderId: '192727806596',
    projectId: 'stressshield-833ce',
    authDomain: 'stressshield-833ce.firebaseapp.com',
    storageBucket: 'stressshield-833ce.appspot.com',
    measurementId: 'G-NQ1ERGMGHS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCo8QVUVaFIcbtb8IJbweEC_2rPYksMu7I',
    appId: '1:192727806596:android:c3ec8a9264b3c03e0908d1',
    messagingSenderId: '192727806596',
    projectId: 'stressshield-833ce',
    storageBucket: 'stressshield-833ce.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1dMHm7FlmM1TVp3EiCKJyqbwjv2DBmIU',
    appId: '1:192727806596:ios:26742083676066300908d1',
    messagingSenderId: '192727806596',
    projectId: 'stressshield-833ce',
    storageBucket: 'stressshield-833ce.appspot.com',
    androidClientId:
        '192727806596-tj6pij23jof5ejpf0tju3f52ufl1vnq5.apps.googleusercontent.com',
    iosClientId:
        '192727806596-l83lt8d7eov94163vt5cg7n2ichv9qcj.apps.googleusercontent.com',
    iosBundleId: 'com.example.stressShield',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1dMHm7FlmM1TVp3EiCKJyqbwjv2DBmIU',
    appId: '1:192727806596:ios:26742083676066300908d1',
    messagingSenderId: '192727806596',
    projectId: 'stressshield-833ce',
    storageBucket: 'stressshield-833ce.appspot.com',
    androidClientId:
        '192727806596-tj6pij23jof5ejpf0tju3f52ufl1vnq5.apps.googleusercontent.com',
    iosClientId:
        '192727806596-l83lt8d7eov94163vt5cg7n2ichv9qcj.apps.googleusercontent.com',
    iosBundleId: 'com.example.stressShield',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDQ_XSu4TVbS3Xn__DaqdTxp70OPKamcfY',
    appId: '1:192727806596:web:1c1a01cf412f20b80908d1',
    messagingSenderId: '192727806596',
    projectId: 'stressshield-833ce',
    authDomain: 'stressshield-833ce.firebaseapp.com',
    storageBucket: 'stressshield-833ce.appspot.com',
    measurementId: 'G-6R2C6RV4C3',
  );
}
