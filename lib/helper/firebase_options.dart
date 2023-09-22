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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyANHG3sMFdnpTmiT_VyHF_ddi-q14F2apM',
    appId: '1:226023654476:android:f139557e3ac46d611d20e9',
    messagingSenderId: '226023654476',
    projectId: 'a-little-bit-stuff',
    databaseURL:
        'https://a-little-bit-stuff-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'a-little-bit-stuff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBJmW2T5GHqmYzWrHSxS0_DGXHtVN0jZs',
    appId: '1:226023654476:ios:2fbcc99d185cefcb1d20e9',
    messagingSenderId: '226023654476',
    projectId: 'a-little-bit-stuff',
    databaseURL:
        'https://a-little-bit-stuff-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'a-little-bit-stuff.appspot.com',
    iosClientId:
        '226023654476-7f6futfauvsfdm9o269b0ldg6d1lrukl.apps.googleusercontent.com',
    iosBundleId: 'com.example.pscMobile',
  );

  // static const FirebaseOptions android = FirebaseOptions(
  //   apiKey: 'AIzaSyDMa1pnMBt4RA3vK3sql1IYbnbpZtWxckc',
  //   appId: '1:492253564447:android:aeed8885699569b168cf2a',
  //   messagingSenderId: '492253564447',
  //   projectId: 'pscdriver-444f3',
  //   databaseURL: '',
  //   storageBucket: 'pscdriver-444f3.appspot.com',
  // );
  //
  // static const FirebaseOptions ios = FirebaseOptions(
  //   apiKey: 'AIzaSyDMa1pnMBt4RA3vK3sql1IYbnbpZtWxckc',
  //   appId: '1:492253564447:android:aeed8885699569b168cf2a',
  //   messagingSenderId: '492253564447',
  //   projectId: 'pscdriver-444f3',
  //   databaseURL: '',
  //   storageBucket: 'pscdriver-444f3.appspot.com',
  //   iosClientId: '',
  //   iosBundleId: '',
  // );
}