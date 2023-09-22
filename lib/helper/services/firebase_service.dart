// https://medium.com/firebase-developers/flutter-fcm-how-to-navigate-to-a-particular-screen-after-tapping-on-push-notification-8cb5d5111ee6

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../firebase_options.dart';

class FirebaseService {
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging =>
      FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;
  // run() async {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );

  //   _firebaseMessaging = FirebaseMessaging.instance;

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     print('messagenotification');
  //     if (message.notification != null) {
  //       print('${message.notification?.title}');
  //     }
  //   });
  // }

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseService._firebaseMessaging = FirebaseMessaging.instance;
    // await FirebaseService.initializeLocalNotifications();
    // await FCMProvider.onMessage();
    await FirebaseService.getDeviceToken();
    // await FirebaseService.onBackgroundMessage();
  }

  /// Registration Token
  static Future<String?> getDeviceToken() async {
    String? b = await _firebaseMessaging?.getToken();
    print(b);
    return b;
  }

  /// Messages handler when app is in the background or terminated.
  static Future<void> onBackgroundMessage() async {
    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {});
  }
}
