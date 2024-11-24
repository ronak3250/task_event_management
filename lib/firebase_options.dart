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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2ne9XnxkzPF3dV-fkeXRE1mR6TEMDOyY',
    appId: '1:881844705993:android:14d5ec4229a48884300b18',
    messagingSenderId: '881844705993',
    projectId: 'eventmanagement-17a1d',
    storageBucket: 'eventmanagement-17a1d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAa8mtZUv0UMFuDVMqjNeKKMY3AyvEKX7w',
    appId: '1:881844705993:ios:c27d8b04899b512c300b18',
    messagingSenderId: '881844705993',
    projectId: 'eventmanagement-17a1d',
    storageBucket: 'eventmanagement-17a1d.firebasestorage.app',
    androidClientId: '881844705993-be8d6647ls1egcjc9lhbhvm3p64690so.apps.googleusercontent.com',
    iosClientId: '881844705993-url9po3sh657ppn2t5309srbk9bddut9.apps.googleusercontent.com',
    iosBundleId: 'com.example.testp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAa8mtZUv0UMFuDVMqjNeKKMY3AyvEKX7w',
    appId: '1:881844705993:ios:c27d8b04899b512c300b18',
    messagingSenderId: '881844705993',
    projectId: 'eventmanagement-17a1d',
    storageBucket: 'eventmanagement-17a1d.firebasestorage.app',
    androidClientId: '881844705993-be8d6647ls1egcjc9lhbhvm3p64690so.apps.googleusercontent.com',
    iosClientId: '881844705993-url9po3sh657ppn2t5309srbk9bddut9.apps.googleusercontent.com',
    iosBundleId: 'com.example.testp',
  );
}