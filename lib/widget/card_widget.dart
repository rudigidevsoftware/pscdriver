import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pscdriver/model/recent_call_model.dart';
import 'package:pscdriver/style/style.dart';

class CardHistoryCall extends StatelessWidget {
  final RecentCall callData;
  const CardHistoryCall({Key? key, required this.callData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 1),
                blurRadius: 5,
                spreadRadius: 1)
          ]),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    callData.isAccepted!
                        ? Bootstrap.telephone_inbound_fill
                        : Bootstrap.telephone_x_fill,
                    color: callData.isAccepted!
                        ? StyleColor().green
                        : StyleColor().redMain,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    callData.isAccepted! ? 'Diterima' : 'Ditolak',
                    style: TextStyle(
                        color: callData.isAccepted!
                            ? StyleColor().green
                            : StyleColor().redMain),
                  )
                ],
              )),
          Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(callData.title ?? '-----'),
                  Text(callData.time ?? '--:--:--'),
                  Text(callData.date ?? '--/--/--')
                ],
              ))
        ],
      ),
    );
  }
}
