import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../controller/main_controller.dart';
import '../style/style.dart';
import '../widget/loading_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController noWaCtrl = TextEditingController();
  TextEditingController pwdCtrl = TextEditingController();
  String messageErrorNoWa = 'Silakan Masukan Username!';
  String messageErrorPwd = 'Silakan Masukan Password!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<MainController>(
          builder: (context, main, _) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Container(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                            height: 200,
                            width: 200,
                            child: SvgPicture.asset('img/svg/ambulance.svg'))),
                    Text(
                      'PSC Ambulance Driver Apps',
                      style: TextStyle(
                          fontSize: 24,
                          color: StyleColor().grey,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Silakan Login',
                      style:
                          TextStyle(fontSize: 18, color: StyleColor().iconGrey),
                    ),
                    const SizedBox(height: 10),
                    Form(
                        key: loginKey,
                        child: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: TextFormField(
                                  controller: noWaCtrl,
                                  decoration: InputDecoration(
                                      hintText: 'Nomor Wa',
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  StyleColor().greyStrokeForm),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  StyleColor().greyStrokeForm),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  StyleColor().greyStrokeForm),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(15),
                                      fillColor: StyleColor().greyBgForm,
                                      label: Text(
                                        'Nomor WA',
                                        style: TextStyle(
                                            color: StyleColor().greyTextForm),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return messageErrorNoWa;
                                    } else {
                                      return null;
                                    }
                                  },
                                )),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: TextFormField(
                                  controller: pwdCtrl,
                                  obscureText: main.isObscure,
                                  decoration: InputDecoration(
                                      hintText: 'Password',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            main.isObscure = !main.isObscure;
                                          },
                                          icon: Icon(
                                            main.isObscure
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: StyleColor().greyTextForm,
                                          )),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  StyleColor().greyStrokeForm),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  StyleColor().greyStrokeForm),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  StyleColor().greyStrokeForm),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(15),
                                      fillColor: StyleColor().greyBgForm,
                                      label: Text(
                                        'Password',
                                        style: TextStyle(
                                            color: StyleColor().greyTextForm),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return messageErrorPwd;
                                    } else {
                                      return null;
                                    }
                                  },
                                )),
                          ],
                        )),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        log('Jwt : ${main.session?.tokenJwt}');
                        if (loginKey.currentState!.validate()) {
                          main.login(noWaCtrl.text, pwdCtrl.text);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => const Dialog(
                                    child: LoadingStateLogin(
                                      textLoading: 'Login Psc Driver..',
                                      height: 200,
                                    ),
                                  ));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: StyleColor().redMain.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(50)),
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // TextButton(
                    //     onPressed: () {
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //           builder: (context) => const ForgotPassword()));
                    //     },
                    //     child: const Text('Lupa Password?')),
                    const SizedBox(height: 20),
                    Text('Version ${main.versionApp}')
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
