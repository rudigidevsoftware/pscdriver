import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:pscdriver/controller/main_controller.dart';
import 'package:pscdriver/style/style.dart';
import 'package:pscdriver/view/profile_view.dart';
import 'package:pscdriver/view/recent_call_view.dart';
import 'package:pscdriver/view/status_view.dart';
import 'package:pscdriver/view/webview_location_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 20);
  static final List<Widget> _widgetOptions = <Widget>[
    const StatusView(),
    const RecentCallView(),
    const ProfileView(),
    const Text(
      'Belum Ada Order Ambulance..',
      style: optionStyle,
    ),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ]),
        child: Consumer<MainController>(
          builder: (context, main, _) => SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 50),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: main.statusAmbulance
                      ? Bootstrap.app_indicator
                      : Bootstrap.app,
                  text: main.statusAmbulance ? 'Stanby..' : 'Home',
                  iconActiveColor: main.statusAmbulance
                      ? StyleColor().green
                      : StyleColor().grey,
                  iconColor: main.statusAmbulance
                      ? StyleColor().green
                      : StyleColor().grey,
                ),
                const GButton(
                  icon: Bootstrap.telephone,
                  text: 'Recent Call',
                ),
                const GButton(
                  icon: Bootstrap.person_gear,
                  text: 'Profile',
                ),
                GButton(
                  icon: Bootstrap.bus_front_fill,
                  text: 'Order',
                  iconColor:
                      main.callData != null ? StyleColor().green : Colors.grey,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                if (main.callData != null && index == 3) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          WebviewLocation(callData: main.callData)));
                }
              },
            ),
          )),
        ),
      ),
    );
  }
}
