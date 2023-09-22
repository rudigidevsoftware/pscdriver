import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_callkeep/flutter_callkeep.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pscdriver/model/firebase_messaging_model.dart';
import 'package:pscdriver/model/recent_call_model.dart';
import 'package:pscdriver/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../api/api.dart';
import '../helper/firebase_options.dart';
import '../main.dart';
import '../model/calldata_model.dart';

enum MainResultState {
  authProcess,
  wrongInput,
  grantedLogin,
  error,
  noData,
  hasData,
  success,
  fails,
  loading,
  searchBlank,
  notDriver
}

class MainController extends ChangeNotifier {
  String versionApp = '1.0.0';
  bool _sessionCheck = false;
  bool _isLogin = false;
  bool _isObscure = true;
  String _messageAuth = '';
  String _messageProfile = '';
  String _messageRegisterFcm = '';
  String? _urlLocationPasien = '';
  String? tokenOrder = '';
  CallData? _callData;
  bool _statusAmbulance = false;
  final Uuid _uuid = const Uuid();
  String? _currentUuid;
  late final FirebaseMessaging _firebaseMessaging;
  SessionUser? _session;
  String? _fcmToken;
  List<RecentCall>? recentCallHistory = [];
  ProfileUser? _profileUser;
  MainResultState? _loginState;
  MainResultState? _profileState;
  MainResultState? _registerFcmState;
  MainResultState? _orderState;
  MainResultState? get loginState => _loginState;
  MainResultState? get profileState => _profileState;
  MainResultState? get registerFcmState => _registerFcmState;
  MainResultState? get orderState => _orderState;
  CallData? get callData => _callData;
  bool get sessionCheck => _sessionCheck;
  String get messageAuth => _messageAuth;
  String get messageProfile => _messageProfile;
  String get messageRegisterFcm => _messageRegisterFcm;
  bool get statusAmbulance => _statusAmbulance;
  bool get isLogin => _isLogin;
  SessionUser? get session => _session;
  ProfileUser? get profileUser => _profileUser;
  String? get urlLocationPasien => _urlLocationPasien;
  bool get isObscure => _isObscure;
  set isObscure(bool value) {
    _isObscure = value;
    notifyListeners();
  }

  String? get currentUuid => _currentUuid;
  set currentUuid(String? value) {
    _currentUuid = value;
    notifyListeners();
  }

  String? get fcmToken => _fcmToken;
  set fcmToken(String? value) {
    _fcmToken = value;
    notifyListeners();
  }

  MainController() {
    print('Provider Main Run------------------');
    print(
        'Provider Main Run------------------Check Session-------------------');
    checkSessionUser();
  }
  //-----Session Section
  Future checkSessionUser() async {
    _sessionCheck = true;
    notifyListeners();
    var sharePrefData = await readSession('sessionLogin');
    notifyListeners();
    if (sharePrefData != 0) {
      _session = SessionUser.fromJsonApi(sharePrefData);
      _sessionCheck = false;
      _isLogin = true;
      notifyListeners();
      checkExpiredToken();
      getProfileUser();
    } else {
      _sessionCheck = false;
      _isLogin = false;
      notifyListeners();
    }
    print('Provider Main Run------------------Firebase Initial'
        '-------------------');
  }

  Future saveSession(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value)).then((value) {
      return value;
    });
  }

  Future readSession(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key);
    if (data != null) {
      return jsonDecode(data);
    } else {
      return 0;
    }
  }

  Future deleteSession(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key).then((value) {
      if (value) {
        print('Delete Success...............');
        return 1;
      } else {
        print('Delete Failed...............');
        return 0;
      }
    });
  }

  Future checkExpiredToken() async {
    if (_isLogin) {
      bool hasExpired = JwtDecoder.isExpired(_session!.tokenJwt!);
      if (hasExpired) {
        logout();
        notifyListeners();
      }
    }
  }

  //-----User Section
  Future login(String noWa, String pwd) async {
    // _isLogin = true;
    // notifyListeners();
    try {
      _messageAuth = '';
      notifyListeners();
      _loginState = MainResultState.loading;
      notifyListeners();
      var res = await ApiService().login(noWa, pwd);
      var data = jsonDecode(res);
      log(data?['token']);
      var resPsc = await ApiService().checkDriverOrNot(data?['token']);
      var dataPsc = jsonDecode(resPsc);
      var isSuccess = data?['success'] ?? false;
      if (isSuccess) {
        if (dataPsc?['metadata']['message'] == 'Unauthorized') {
          _loginState = MainResultState.notDriver;
          _messageAuth = 'Mohon Maaf anda tidak terdaftar sebagai Driver PSC?';
          notifyListeners();
        } else {
          await saveSession('sessionLogin', data);
          _session = SessionUser.fromJsonApi(data);
          _isLogin = true;
          _messageAuth = 'Login Berhasil';
          notifyListeners();
          getProfileUser();
          _loginState = MainResultState.success;
          notifyListeners();
        }
      } else {
        _messageAuth = data?['messages']['error'];
        _loginState = MainResultState.fails;
        notifyListeners();
      }
    } catch (err) {
      _messageAuth = err.toString();
      _loginState = MainResultState.error;
      notifyListeners();
    }
  }

  Future logout() async {
    await deleteSession('sessionLogin');
    _isLogin = false;
    _session = null;
    notifyListeners();
  }

  Future getProfileUser() async {
    // Check Expired Session Token JWT
    await checkExpiredToken();
    try {
      _messageProfile = '';
      notifyListeners();
      _profileState = MainResultState.loading;
      notifyListeners();
      var res =
          await ApiService().getProfileUser(session!.tokenJwt!.toString());
      var data = jsonDecode(res);
      var isSuccess = data?['success'] ?? false;
      if (isSuccess) {
        var resData = ProfileUserGet.fromJson(data);
        _profileUser = resData.data;
        _profileState = MainResultState.success;
        notifyListeners();
      } else {
        _messageProfile = data?['messages']['error'];
        _profileState = MainResultState.fails;
        notifyListeners();
      }
    } catch (err) {
      _messageProfile = err.toString();
      _profileState = MainResultState.error;
      notifyListeners();
    }
  }

  //-----Main Section

  Future changeStatusAmbulanceReady() async {
    _messageRegisterFcm = 'Mengirim ke Server..';
    _registerFcmState = MainResultState.loading;
    notifyListeners();
    var sendFcm =
        await ApiService().registerTokenFCM(_session!.tokenJwt!, _fcmToken!);
    var updateStatus =
        await ApiService().updateDriverStatus(_session!.tokenJwt!, 'ready');
    if (sendFcm != 0) {
      if (updateStatus != 0) {
        _registerFcmState = MainResultState.success;
        _statusAmbulance = true;
        notifyListeners();
      } else {
        _messageRegisterFcm = 'Gagal Update Status Driver?..';
        _registerFcmState = MainResultState.fails;
        notifyListeners();
      }
    } else {
      _messageRegisterFcm = 'Gagal Mengirim Token?..';
      _registerFcmState = MainResultState.fails;
      notifyListeners();
    }
  }

  Future changeStatusAmbulanceNotReady() async {
    _messageRegisterFcm = 'Stop Status Ready..';
    _registerFcmState = MainResultState.loading;
    notifyListeners();
    var updateStatus =
        await ApiService().updateDriverStatus(_session!.tokenJwt!, 'notready');
    if (updateStatus != 0) {
      _registerFcmState = MainResultState.success;
      _statusAmbulance = false;
      notifyListeners();
    } else {
      _registerFcmState = MainResultState.fails;
      notifyListeners();
    }
  }

  Future acceptOrderAmbulance(String tokenOrder) async {
    _orderState = MainResultState.loading;
    notifyListeners();
    var updateStatus = await ApiService()
        .responseOrder(_session!.tokenJwt!, tokenOrder, 'accepted');
    if (updateStatus != 0) {
      _orderState = MainResultState.success;
      notifyListeners();
    } else {
      _orderState = MainResultState.fails;
      notifyListeners();
    }
  }

  Future rejectOrderAmbulance(String tokenOrder) async {
    _orderState = MainResultState.loading;
    notifyListeners();
    var updateStatus = await ApiService()
        .responseOrder(_session!.tokenJwt!, tokenOrder, 'rejected');
    if (updateStatus != 0) {
      _orderState = MainResultState.success;
      notifyListeners();
    } else {
      _orderState = MainResultState.fails;
      notifyListeners();
    }
  }

  initFirebase(Future<void> Function(RemoteMessage message) function) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    _firebaseMessaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(function);
    FirebaseMessaging.onMessage.listen((RemoteMessage messageFirebase) async {
      var tokenOrderRes =
          ResponseFirebaseMessaging.fromJsonApi(messageFirebase.data);
      log('-------------------${tokenOrderRes.tokenOrder!}');
      tokenOrder = tokenOrderRes.tokenOrder;
      notifyListeners();
      _currentUuid = _uuid.v4();
      displayIncomingCall(_currentUuid!, messageFirebase);
      notifyListeners();
    });
    _firebaseMessaging.getToken().then((token) {
      _fcmToken = token;
      notifyListeners();
      print('Device Token FCM: $token');
    });
  }

  Future<CallKeepCallData?> getCurrentCall() async {
    //check current call from pushkit if possible
    log('getCurrentCall Running....');
    var calls = await CallKeep.instance.activeCalls();
    if (calls.isNotEmpty) {
      _currentUuid = calls[0].uuid;
      return calls[0];
    } else {
      _currentUuid = "";
      return null;
    }
  }

  Future addRecentCallToList(RecentCall recentCall) async {
    log('Menambah History Penggilan Running....');
    recentCallHistory?.add(recentCall);
    notifyListeners();
    log('Recent Call Length : ${recentCallHistory?.length}');
  }

  Future updateUrlLocationPasien(String url) async {
    _urlLocationPasien = url;
    notifyListeners();
  }

  Future updateTokenOrder(String tokenOrderNew) async {
    tokenOrder = tokenOrderNew;
    notifyListeners();
  }

  Future saveAcceptedCall(CallData callDatas) async {
    _callData = callDatas;
    notifyListeners();
  }
}
