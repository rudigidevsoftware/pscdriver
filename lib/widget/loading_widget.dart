import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../controller/main_controller.dart';
import '../style/style.dart';

class Loading extends StatelessWidget {
  final String textLoading;
  final double iconSize;
  const Loading({Key? key, required this.textLoading, required this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.fallingDot(
              color: StyleColor().blueMain, size: iconSize),
          Text(textLoading)
        ],
      ),
    );
  }
}

class AlertWidget extends StatelessWidget {
  final String text;
  final String svg;
  final double svgSize;
  const AlertWidget(
      {Key? key, required this.text, required this.svg, required this.svgSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('img/svg/$svg.svg', width: svgSize, height: svgSize),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class LoadingStateLogin extends StatelessWidget {
  final String textLoading;
  final double height;
  const LoadingStateLogin(
      {Key? key, required this.textLoading, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder: (context, main, _) {
        if (main.loginState == MainResultState.loading) {
          return Container(
            height: height,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.fallingDot(
                    color: StyleColor().blueMain, size: 50),
                Text(textLoading)
              ],
            ),
          );
        } else if (main.loginState == MainResultState.notDriver) {
          return Container(
            height: height,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('img/svg/warning.svg', width: 80, height: 80),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    main.messageAuth,
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('ok'))
              ],
            ),
          );
        } else if (main.loginState == MainResultState.success) {
          return Container(
            height: height,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('img/svg/check.svg', width: 80, height: 80),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    main.messageAuth,
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      int count = 1;
                      Navigator.of(context).popUntil((_) => count-- <= 0);
                    },
                    child: const Text('ok'))
              ],
            ),
          );
        } else if (main.loginState == MainResultState.fails) {
          return Container(
            height: height,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('img/svg/warning.svg', width: 80, height: 80),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    main.messageAuth,
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('ok'))
              ],
            ),
          );
        } else if (main.loginState == MainResultState.error) {
          return Container(
            height: height,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('img/svg/error.svg', width: 80, height: 80),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    main.messageAuth,
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('ok'))
              ],
            ),
          );
        } else {
          return Container(
            height: height,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('img/svg/404.svg', width: 80, height: 80),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    main.messageAuth,
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('ok'))
              ],
            ),
          );
        }
      },
    );
  }
}
