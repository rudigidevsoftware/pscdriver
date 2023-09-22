import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:location_geocoder/location_geocoder.dart';

class PhoneService extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  LocationData? location;
  bool _isOnline = false;
  Location mylocation = Location();
  bool _isGpsOn = false;
  bool _checkInternet = false;
  bool _gpsAccessGranted = false;
  bool _getLocationRunning = false;
  String _lat = '0';
  String _long = '-0';
  static const _apiKey = 'AIzaSyAd4rEAQqf58fCJGABqW99teDP9BcuyN08';
  final LocatitonGeocoder geocoder = LocatitonGeocoder(_apiKey);
  List<Address>? addressUser;
  StreamSubscription<LocationData>? locationListen;

  String get lat => _lat;
  set lat(String value) {
    _lat = value;
    notifyListeners();
  }

  String get long => _long;
  set long(String value) {
    _long = value;
    notifyListeners();
  }

  bool get gpsAccessGranted => _gpsAccessGranted;

  bool get getLocationRunning => _getLocationRunning;

  bool get isOnline => _isOnline;

  bool get isGpsOn => _isGpsOn;

  bool get checkInternet => _checkInternet;
  PhoneService() {
    print('Provider Phone Run ---------------------------');
    startMonitoring();
  }
  startMonitoring() async {
    _checkInternet = true;
    notifyListeners();
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((event) async {
      print('Listening Runing...');
      if (event == ConnectivityResult.none) {
        _isOnline = false;
        _checkInternet = false;
        notifyListeners();
      } else {
        print('Update Internet Connection');
        await updateConnectStatus().then((bool isConnected) {
          _isOnline = isConnected;
          notifyListeners();
        });
        print('Check Gps Is On');
        await initGpsIsOn();
        await initGpsHaveAccess();
        await getLocationUser();
        _checkInternet = false;
        notifyListeners();
      }
    });
  }

  Future initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        print('Offline Bos');
        _isOnline = false;
      } else {
        print('Online Bos');
        _isOnline = true;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      throw Exception('Koneksi Bermasalah! (${e.message})');
    }
  }

  Future<bool> updateConnectStatus() async {
    bool isConnected = false;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }

  Future getLocationUser() async {
    print('get location function run');
    try {
      await mylocation.getLocation().then((value) => {
            _lat = value.latitude.toString(),
            _long = value.longitude.toString(),
            location = value
          });
      notifyListeners();
      print('Latitude : ${location?.latitude.toString()}');
      print(location?.longitude);
      await getAddressUser();
    } catch (err) {
      print(err);
    }
  }

  Future getAddressUser() async {
    final address = await geocoder.findAddressesFromCoordinates(
        Coordinates(location?.latitude, location?.longitude));
    addressUser = address;
    print('======================${address.first.addressLine}');
    notifyListeners();
  }

  Future refreshLocationUser() async {
    print('Refresh location function run');
    _getLocationRunning = true;
    notifyListeners();
    try {
      await mylocation.getLocation().then((value) => {
            _lat = value.latitude.toString(),
            _long = value.longitude.toString(),
            location = value
          });
      notifyListeners();
      print('Latitude : ${location?.latitude.toString()}');
      print(location?.longitude);
    } catch (err) {
      print(err);
    }
    _getLocationRunning = false;
    notifyListeners();
  }

  Future initGpsIsOn() async {
    try {
      var status = await mylocation.serviceEnabled();
      if (status) {
        _isGpsOn = true;
        notifyListeners();
      } else {
        var getGpsOn = await mylocation.requestService();
        if (getGpsOn) {
          _isGpsOn = true;
          notifyListeners();
        }
      }
    } on PlatformException catch (e) {
      print('PlatformException: $e');
    }
  }

  Future initGpsHaveAccess() async {
    try {
      var status = await mylocation.hasPermission();
      if (status == PermissionStatus.granted ||
          status == PermissionStatus.grantedLimited) {
        _gpsAccessGranted = true;
        notifyListeners();
      } else {
        await mylocation.requestPermission();
      }
    } on PlatformException catch (e) {
      print('PlatformException: ' + e.toString());
    }
  }

  Future runBackgroundLocation() async {
    await mylocation.enableBackgroundMode(enable: true);
    locationListen =
        mylocation.onLocationChanged.listen((LocationData currentLocation) {
      log('Current Location : ${currentLocation.latitude} ${currentLocation.longitude}');
      notifyListeners();
    });
  }
  Future stopBackgroundLocation() async {
    locationListen?.cancel();
    notifyListeners();
  }
}
