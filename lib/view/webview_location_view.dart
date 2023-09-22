import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../model/calldata_model.dart';
import '../widget/loading_widget.dart';

class WebviewLocation extends StatefulWidget {
  final CallData? callData;
  const WebviewLocation({Key? key, required this.callData}) : super(key: key);

  @override
  State<WebviewLocation> createState() => _WebviewLocationState();
}

class _WebviewLocationState extends State<WebviewLocation> {
  late InAppWebViewController webViewController;
  final GlobalKey webViewKey = GlobalKey();
  bool webProcess = false;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black87,
            )),
        title: Text(
          'Order Ambulance : ${widget.callData?.extra?.tokenOrder}',
          style: const TextStyle(color: Colors.black87),
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                'https://psc.magelangkab.go.id/${widget.callData?.extra?.tokenOrder}',
              )),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(useOnDownloadStart: true),
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  webProcess = true;
                });
              },
              onLoadStop: (controller, url) {
                setState(() {
                  webProcess = false;
                });
              }),
          webProcess
              ? const Loading(textLoading: 'Loading..', iconSize: 30)
              : const Stack(),
        ],
      ),
    );
  }
}
