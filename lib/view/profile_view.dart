import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../controller/main_controller.dart';
import '../style/style.dart';
import '../widget/loading_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<MainController>(
        builder: (context, main, _) {
          if (main.profileState == MainResultState.loading) {
            return const Loading(textLoading: 'Mengambil Data..', iconSize: 40);
          } else if (main.profileState == MainResultState.success) {
            return Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Profile',
                      style: TextStyle(
                          color: StyleColor().iconBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // main.profileChangeInitFunction();
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         ProfileChange(user: main.profileUser!)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) =>
                                //         const ChangePassword()));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: StyleColor().backIconRed,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.lock,
                                          color: StyleColor().iconRed,
                                        ),
                                      ),
                                      const Text('Ubah Password')
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                          child: SizedBox(
                                            height: 200,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                    'Anda Yakin Logout?'),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          main.logout();
                                                          int count = 1;
                                                          Navigator.of(context)
                                                              .popUntil((_) =>
                                                                  count-- <= 0);
                                                        },
                                                        child:
                                                            const Text('Ya')),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            'Batal')),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: StyleColor().backIconGrey,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.logout,
                                          color: StyleColor().iconGrey,
                                        ),
                                      ),
                                      const Text('Logout')
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 30),
                    Consumer<MainController>(
                      builder: (context, main, _) => Center(
                          child: Text(
                        'Version ${main.versionApp}',
                        style: TextStyle(color: StyleColor().blueMain),
                      )),
                    ),
                  ],
                ));
          } else if (main.profileState == MainResultState.fails) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'img/svg/warning.svg',
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  const Text('Maaf Gagal Mengambil Data..'),
                  TextButton(
                      onPressed: () {
                        main.getProfileUser();
                      },
                      child: const Text('Ulangi'))
                ],
              ),
            );
          } else if (main.profileState == MainResultState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'img/svg/error.svg',
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  const Text('Error..'),
                  Text(main.messageProfile ?? '----'),
                  TextButton(
                      onPressed: () {
                        main.getProfileUser();
                      },
                      child: const Text('Ulangi'))
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'img/svg/satellite.svg',
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  const Text('Masalah Dengan Koneksi..'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
