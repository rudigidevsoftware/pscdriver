import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../controller/main_controller.dart';
import '../style/style.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController noWaCtrl = TextEditingController();
  TextEditingController pwdCtrl = TextEditingController();
  String messageErrorName = 'Silakan Masukan Nama lengkap';
  String messageErrorEmail = 'Silakan Masukan Email';
  String messageErrorNoWa = 'Silakan Masukan Nomor WA';
  String messageErrorPwd = 'Silakan Masukan Password';
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder: (context, main, _) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Register PSC Driver',
                style: TextStyle(color: StyleColor().greyMain)),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: StyleColor().greyMain,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset('img/ambulancedriver.jpg'))),
                  Form(
                      key: registerKey,
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: TextFormField(
                                controller: nameCtrl,
                                decoration: InputDecoration(
                                    hintText: 'Nama Lengkap',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(15),
                                    fillColor: StyleColor().greyBgForm,
                                    label: Text(
                                      'Nama Lengkap',
                                      style: TextStyle(
                                          color: StyleColor().greyTextForm),
                                    )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return messageErrorName;
                                  } else {
                                    return null;
                                  }
                                },
                              )),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: TextFormField(
                                controller: emailCtrl,
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(15),
                                    fillColor: StyleColor().greyBgForm,
                                    label: Text(
                                      'Email',
                                      style: TextStyle(
                                          color: StyleColor().greyTextForm),
                                    )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return messageErrorEmail;
                                  } else if (EmailValidator.validate(value) ==
                                      false) {
                                    return 'Format Email Tidak Valid?';
                                  } else {
                                    return null;
                                  }
                                },
                              )),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: TextFormField(
                                controller: noWaCtrl,
                                decoration: InputDecoration(
                                    hintText: 'Nomor WA',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
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
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                              )),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
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
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: StyleColor().greyStrokeForm),
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
                    splashColor: Colors.grey,
                    onTap: () async {
                      if (registerKey.currentState!.validate()) {
                        // main.register(nameCtrl.text, emailCtrl.text,
                        //     noWaCtrl.text, pwdCtrl.text);
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) => const Dialog(
                        //           child: LoadingStateRegister(
                        //             textLoading: 'Register MSS..',
                        //             height: 200,
                        //           ),
                        //         ));
                      }
                      // var now = DateTime.now().millisecondsSinceEpoch;
                      // print(now);
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: StyleColor().blueMain,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Version ${main.versionApp}')
                ],
              ),
            ),
          )),
    );
  }
}
