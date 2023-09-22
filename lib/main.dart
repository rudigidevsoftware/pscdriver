import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkeep/flutter_callkeep.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pscdriver/controller/main_controller.dart';
import 'package:pscdriver/controller/phone_controller.dart';
import 'package:pscdriver/model/calldata_model.dart';
import 'package:pscdriver/model/firebase_messaging_model.dart';
import 'package:pscdriver/view/login_view.dart';
import 'package:pscdriver/view/main_view.dart';
import 'package:pscdriver/widget/app_route.dart';
import 'package:pscdriver/widget/navigation_service.dart';
import 'package:uuid/uuid.dart';

import 'model/recent_call_model.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  displayIncomingCall(const Uuid().v4(), message);
}

Future<void> displayIncomingCall(String uuid, RemoteMessage message) async {
  String tokenOrderRes =
      ResponseFirebaseMessaging.fromJsonApi(message.data).tokenOrder!;
  final config = CallKeepIncomingConfig(
    uuid: uuid,
    callerName: message.notification?.title ?? 'Membutuhkan Ambulance...',
    appName: 'Psc Ambulance',
    avatar: 'https://i.pravatar.cc/100',
    handle: tokenOrderRes ?? '',
    hasVideo: false,
    duration: 30000,
    acceptText: 'Terima',
    declineText: 'Tidak',
    missedCallText: 'Missed call',
    callBackText: 'Call back',
    extra: <String, dynamic>{'tokenOrder': tokenOrderRes ?? '-'},
    headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
    androidConfig: CallKeepAndroidConfig(
      logo: "ic_logo",
      showCallBackAction: true,
      showMissedCallNotification: true,
      ringtoneFileName: 'system_ringtone_default',
      accentColor: '#0955fa',
      backgroundUrl: 'assets/test.png',
      incomingCallNotificationChannelName: 'Incoming Calls',
      missedCallNotificationChannelName: 'Missed Calls',
    ),
    iosConfig: CallKeepIosConfig(
      iconName: 'CallKitLogo',
      handleType: CallKitHandleType.generic,
      isVideoSupported: true,
      maximumCallGroups: 2,
      maximumCallsPerCallGroup: 1,
      audioSessionActive: true,
      audioSessionPreferredSampleRate: 44100.0,
      audioSessionPreferredIOBufferDuration: 0.005,
      supportsDTMF: true,
      supportsHolding: true,
      supportsGrouping: false,
      supportsUngrouping: false,
      ringtoneFileName: 'system_ringtone_default',
    ),
  );
  await CallKeep.instance.displayIncomingCall(config);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PhoneService()),
      ChangeNotifierProvider(create: (context) => MainController())
    ],
    child: const MyApps(),
  ));
}

class MyApps extends StatefulWidget {
  const MyApps({Key? key}) : super(key: key);

  @override
  State<MyApps> createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> with WidgetsBindingObserver {
  String textEvents = "";
  @override
  void initState() {
    super.initState();
    Provider.of<MainController>(context, listen: false)
        .initFirebase(_firebaseMessagingBackgroundHandler);
    WidgetsBinding.instance.addObserver(this);
    //Check call when open app from terminated
    checkAndNavigationCallingPage();
    listenerEvent(onEvent);
  }

  checkAndNavigationCallingPage() async {
    var currentCall = await Provider.of<MainController>(context, listen: false)
        .getCurrentCall();
    print('not answered call ${currentCall?.toMap()}');
    if (currentCall != null) {
      NavigationService.instance.pushNamedIfNotCurrent(AppRoute.callingPage,
          args: currentCall.toMap());
    }
  }

  Future<void> listenerEvent(Function? callback) async {
    try {
      CallKeep.instance.onEvent.listen((event) async {
        // TODO: Implement other events
        if (event == null) return;
        switch (event.type) {
          case CallKeepEventType.callAccept:
            log('----------------------------Diterima');
            final data = event.data as CallKeepCallData;
            CallData callData = CallData.fromJson(data.toMap());
            print('============================${callData.extra?.tokenOrder!}');
            await addHistoryCallAndUpdateTokenOrder(data);
            await acceptOrder(callData.extra!.tokenOrder!);
            NavigationService.instance
                .pushNamedIfNotCurrent(AppRoute.callingPage, args: data.handle);
            if (callback != null) callback.call(event);
            break;
          case CallKeepEventType.callDecline:
            log('----------------------------Ditolak');
            final data = event.data as CallKeepCallData;
            log('----------------------------${data.handle}');
            CallData callData = CallData.fromJson(data.toMap());
            await addHistoryCall(data);
            await rejectOrder(callData.extra!.tokenOrder!);
            print('call declined: ${data.toMap()}');
            await requestHttp("ACTION_CALL_DECLINE_FROM_DART");
            if (callback != null) callback.call(data);
            break;
          default:
            break;
        }
      });
    } on Exception {}
  }

  Future<void> requestHttp(content) async {
    get(Uri.parse(
        'https://webhook.site/2748bc41-8599-4093-b8ad-93fd328f1cd2?data=$content'));
  }

  Future addHistoryCallAndUpdateTokenOrder(CallKeepCallData data) async {
    var tokenOrder = Extra.fromJson(data.extra!).tokenOrder;
    print('Add Histori----------------------- : $tokenOrder}');
    var callData = CallData(
        id: data.uuid,
        callerName: data.callerName,
        handle: tokenOrder,
        hasVideo: data.hasVideo,
        duration: data.duration,
        isAccepted: true,
        extra: Extra.fromJson(data.extra!));
    var recentCall = RecentCall(
        uuid: data.uuid,
        title: data.callerName,
        body: '-',
        time: DateFormat('HH:mm:ss').format(DateTime.now()),
        date: DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
        isAccepted: true);
    Provider.of<MainController>(context, listen: false)
        .addRecentCallToList(recentCall);
    Provider.of<MainController>(context, listen: false)
        .updateTokenOrder(tokenOrder!);
    log('--------------Save Accepted Call--------------');
    Provider.of<MainController>(context, listen: false)
        .saveAcceptedCall(callData);
  }

  Future addHistoryCall(CallKeepCallData data) async {
    Provider.of<MainController>(context, listen: false).addRecentCallToList(
        RecentCall(
            uuid: data.uuid,
            title: data.callerName,
            body: '-',
            time: DateFormat('HH:mm:ss').format(DateTime.now()),
            date: DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
            isAccepted: data.isAccepted));
  }

  Future acceptOrder(String tokenOrder) async {
    await Provider.of<MainController>(context, listen: false)
        .acceptOrderAmbulance(tokenOrder);
  }

  Future rejectOrder(String tokenOrder) async {
    await Provider.of<MainController>(context, listen: false)
        .rejectOrderAmbulance(tokenOrder);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    print(state);
    if (state == AppLifecycleState.resumed) {
      //Check call when open app from background
      checkAndNavigationCallingPage();
    }
  }

  onEvent(event) {
    if (!mounted) return;
    setState(() {
      textEvents += "${event.toString()}\n";
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      onGenerateRoute: AppRoute.generateRoute,
      navigatorKey: NavigationService.instance.navigationKey,
      navigatorObservers: <NavigatorObserver>[
        NavigationService.instance.routeObserver
      ],
      home: Consumer<PhoneService>(
        builder: (context, phone, _) {
          if (phone.checkInternet) {
            return const Scaffold(
              body: Center(
                child: Text('Mendapatkan Lokasi Perangkat..'),
              ),
            );
          } else {
            return Consumer<MainController>(
              builder: (context, main, _) {
                if (main.sessionCheck) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Session Checking..'),
                    ),
                  );
                } else {
                  if (main.isLogin) {
                    return const MainView();
                  } else {
                    return const LoginView();
                  }
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<void> getDevicePushTokenVoIP() async {
    var devicePushTokenVoIP = await CallKeep.instance.getDevicePushTokenVoIP();
    print(devicePushTokenVoIP);
  }
}
