import 'package:flutter/material.dart';
import 'package:pscdriver/model/calldata_model.dart';
import 'package:pscdriver/view/webview_location_view.dart';

import '../view/main_view.dart';

class AppRoute {
  static const homePage = '/home_page';

  static const callingPage = '/calling_page';

  static Route<Object>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
            builder: (_) => const MainView(), settings: settings);
      case callingPage:
        return MaterialPageRoute(
            builder: (_) => WebviewLocation(
                  callData: CallData.fromJson(
                      settings.arguments as Map<String, dynamic>),
                ),
            settings: settings);
      default:
        return null;
    }
  }
}
