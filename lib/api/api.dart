import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService {
  // Api SLO
  static const String tokenApi =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NzY2MDU5NjYsImlzcyI6ImRpc2tvbWluZm8ifQ.ggRlUf9Pky0pU1m0ywqAaxt-P28qiMdkQaFD06K-I0Y';
  static const String sloUrl = 'https://slo.magelangkab.go.id/api/';
  static const String pscUrl = 'https://psc.magelangkab.go.id/api/';

  //-----------------------------------------------------------------------------------------
  Future login(String user, String pwd) async {
    final map = <String, dynamic>{};
    map['phone_number'] = user;
    map['password'] = pwd;
    var response = await http.post(Uri.parse('${sloUrl}users/login'),
        headers: {'Authorization': 'Bearer $tokenApi'}, body: jsonEncode(map));
    return response.body;
  }

  Future getProfileUser(String jsonToken) async {
    var response = await http.get(Uri.parse('${sloUrl}users'),
        headers: {'Authorization': 'Bearer $jsonToken'});
    return response.body;
  }

  Future checkDriverOrNot(String tokenJwt) async {
    var response = await http.get(Uri.parse('${pscUrl}driver/ping'), headers: {
      'x-authorization': tokenJwt,
      'x-domain': 'com.magelangkab.pscdriver'
    });
    log('Cek Driver or Not');
    log(response.body);
    return response.body;
  }

  Future registerTokenFCM(String tokenJwt, String fcmToken) async {
    final map = <String, dynamic>{};
    map['fcm-token'] = fcmToken;
    var response = await http.post(
        Uri.parse('${pscUrl}driver/register-fcm-token'),
        headers: {
          'x-authorization': tokenJwt,
          'x-domain': 'com.magelangkab.pscdriver'
        },
        body: jsonEncode(map));
    log('Response Fcm Register : ${response.body}');
    print('FCM Token : $fcmToken');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 0;
    }
  }

  Future updateDriverStatus(String tokenJwt, String status) async {
    var response = await http.get(Uri.parse('${pscUrl}driver/status/:$status'),
        headers: {
          'x-authorization': tokenJwt,
          'x-domain': 'com.magelangkab.pscdriver'
        });
    log('Update Driver Status : $status');
    log(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 0;
    }
  }

  Future responseOrder(
      String tokenJwt, String tokenOrder, String status) async {
    var response = await http
        .get(Uri.parse('${pscUrl}driver/order/$tokenOrder/:$status'), headers: {
      'x-authorization': tokenJwt,
      'x-domain': 'com.magelangkab.pscdriver'
    });
    log('Update Driver Status : $tokenOrder');
    log('Update Driver Status : $status');
    log(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 0;
    }
  }
}
