import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pscdriver/controller/main_controller.dart';
import 'package:pscdriver/widget/card_widget.dart';

class RecentCallView extends StatefulWidget {
  const RecentCallView({Key? key}) : super(key: key);

  @override
  State<RecentCallView> createState() => _RecentCallViewState();
}

class _RecentCallViewState extends State<RecentCallView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<MainController>(
          builder: (context, main, _) {
            if (main.recentCallHistory == null) {
              return const Center(
                child: Text('Belum Ada Panggilan..'),
              );
            } else {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: ListView.builder(
                    itemCount: main.recentCallHistory?.length,
                    itemBuilder: (BuildContext context, int i) {
                      return CardHistoryCall(
                          callData: main.recentCallHistory![i]);
                    }),
              );
            }
          },
        ),
      ),
    );
  }
}
