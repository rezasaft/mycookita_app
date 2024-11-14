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
    apiKey: 'AIzaSyAUt-aKVZBYjNuuEg92wlN9ONDvIL1fe00',
    appId: '1:509956776702:web:ed935b065dfb58a2e4fbaf',
    messagingSenderId: '509956776702',
    projectId: 'cookita-apps',
    authDomain: 'cookita-apps.firebaseapp.com',
    storageBucket: 'cookita-apps.firebasestorage.app',
    measurementId: 'G-D6JW6YTG1S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnZXSYGXOIDZtGU4OjZADsTYH_WCcoh-w',
    appId: '1:509956776702:android:cd3d7dc42a448326e4fbaf',
    messagingSenderId: '509956776702',
    projectId: 'cookita-apps',
    storageBucket: 'cookita-apps.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZtXdWD-xw26gn2mAP5bm5LfAAJZ3eTFM',
    appId: '1:509956776702:ios:e529bfd299db95e0e4fbaf',
    messagingSenderId: '509956776702',
    projectId: 'cookita-apps',
    storageBucket: 'cookita-apps.firebasestorage.app',
    iosBundleId: 'com.example.mycookitaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZtXdWD-xw26gn2mAP5bm5LfAAJZ3eTFM',
    appId: '1:509956776702:ios:e529bfd299db95e0e4fbaf',
    messagingSenderId: '509956776702',
    projectId: 'cookita-apps',
    storageBucket: 'cookita-apps.firebasestorage.app',
    iosBundleId: 'com.example.mycookitaApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAUt-aKVZBYjNuuEg92wlN9ONDvIL1fe00',
    appId: '1:509956776702:web:c93172f7a9ded4ace4fbaf',
    messagingSenderId: '509956776702',
    projectId: 'cookita-apps',
    authDomain: 'cookita-apps.firebaseapp.com',
    storageBucket: 'cookita-apps.firebasestorage.app',
    measurementId: 'G-XG116CDPRM',
  );

}