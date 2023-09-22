import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pscdriver/controller/main_controller.dart';
import 'package:pscdriver/controller/phone_controller.dart';
import 'package:pscdriver/style/style.dart';

class StatusView extends StatelessWidget {
  const StatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer2<PhoneService, MainController>(
        builder: (context, phone, main, _) {
      if (main.registerFcmState == MainResultState.loading) {
        return Center(
          child: Text(main.messageRegisterFcm),
        );
      } else {
        if (main.statusAmbulance) {
          return readyStatus();
        } else {
          return notReadyStatus();
        }
      }
    }));
  }

  Widget readyStatus() {
    return Consumer2<PhoneService, MainController>(
        builder: (context, phone, main, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('img/lottie/location-bounce.json',
                    height: 180, width: 180),
                const Text(
                  'Menunggu Permintaan...',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: OutlinedButton.icon(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          backgroundColor:
                              MaterialStatePropertyAll(StyleColor().green)),
                      onPressed: () {
                        main.changeStatusAmbulanceNotReady();
                        phone.stopBackgroundLocation();
                      },
                      icon: const Icon(Bootstrap.stop_circle,
                          color: Colors.white),
                      label: const Text(
                        'Berhenti',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ));
  }

  Widget notReadyStatus() {
    return Consumer2<PhoneService, MainController>(
        builder: (context, phone, main, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('img/lottie/ambulance-blue.json',
                    height: 200, width: 200),
                const Text(
                  '.......................',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: OutlinedButton.icon(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          backgroundColor:
                              MaterialStatePropertyAll(StyleColor().grey)),
                      onPressed: () {
                        main.changeStatusAmbulanceReady();
                        phone.runBackgroundLocation();
                      },
                      icon:
                          const Icon(Bootstrap.broadcast, color: Colors.white),
                      label: const Text(
                        'Ambulance Siap?',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ));
  }
}
