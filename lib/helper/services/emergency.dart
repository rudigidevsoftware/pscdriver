import 'dart:async';

import 'package:flutter_callkeep/flutter_callkeep.dart';

class Emergency {
  static void listen() {
    CallKeep.instance.onEvent.listen((event) async {
      if (event == null) return;
      switch (event.type) {
        case CallKeepEventType.callAccept:
          final data = event.data as CallKeepCallData;
          print('call answered: ${data.toMap()}');
          break;
        case CallKeepEventType.callDecline:
          final data = event.data as CallKeepCallData;
          print('call declined: ${data.toMap()}');
          break;
        default:
          break;
      }
    });
  }

  static Future<void> incomingCall(String uuid) async {
    final callKeepBaseConfig = CallKeepBaseConfig(
      appName: 'Done',
      androidConfig: CallKeepAndroidConfig(
        logo: '',
        notificationIcon: '',
        // ringtoneFileName: 'ringtone.mp3',
        accentColor: '#34C7C2',
      ),
      iosConfig: CallKeepIosConfig(
        iconName: 'Icon',
        maximumCallGroups: 1,
      ),
    );

    final config = CallKeepIncomingConfig.fromBaseConfig(
        config: callKeepBaseConfig,
        uuid: uuid,
        contentTitle: 'Incoming call from Done',
        hasVideo: false,
        handle: '0909',
        callerName: 'incomingCallUsername',
        extra: <String, dynamic>{'userId': '1a2b3c4d'});
    await CallKeep.instance.displayIncomingCall(config);
  }
}
