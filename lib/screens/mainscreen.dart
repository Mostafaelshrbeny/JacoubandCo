import 'dart:io';

import 'package:chatjob/Hive/LocalAuth/LocalAuth.dart';
import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/method/TokenRefresh.dart';
import 'package:chatjob/screens/mainscreens/chats.dart';
import 'package:chatjob/screens/mainscreens/portfolio.dart';
import 'package:chatjob/screens/mainscreens/profil.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({
    super.key,
    this.inApp = false,
  });
  final bool inApp;
  @override
  State<Mainscreen> createState() => _MainscreenState();
}

int current = 0;

class _MainscreenState extends State<Mainscreen> {
  @override
  void initState() {
    refreshToken();

    pref.getString('face') == 'Enabled' && widget.inApp == false
        ? applock()
        : null;
    super.initState();
  }

  late bool x;
  bool canUse = false;
  applock() async {
    x = await LocalAuth.authenticate();
    setState(() {
      canUse = x;
    });
    canUse ? null : exit(0);
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      Portfolioscreen(
        admin: loginbox!.get('Admin'),
      ),
      Chatsscreen(
        admin: loginbox!.get('Admin'),
      ),
      Profilscreen(
        admin: loginbox!.get('Admin'),
      )
    ];
    return Builder(builder: (cx) {
      return WillPopScope(
        onWillPop: () async {
          showModalBottomSheet(
              context: cx,
              builder: (context) {
                return OUT(
                  cx: cx,
                );
              });

          return false;
        },
        child: canUse || widget.inApp || pref.getString('face') == 'Disabled'
            ? Scaffold(
                resizeToAvoidBottomInset: false,
                body: pages[current],
                bottomNavigationBar: Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: ShapeDecoration(
                    color: const Color.fromRGBO(2, 20, 31, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    child: BottomNavigationBar(
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      backgroundColor: const Color.fromRGBO(2, 20, 31, 1),
                      elevation: 20,
                      items: [
                        BottomNavigationBarItem(
                          label: '',
                          icon: FaIcon(
                            FontAwesomeIcons.briefcase,
                            size: 20,
                            color: current == 0
                                ? const Color.fromRGBO(142, 112, 79, 1)
                                : const Color.fromRGBO(91, 125, 144, 1),
                          ),
                        ),
                        BottomNavigationBarItem(
                          label: '',
                          icon: FaIcon(
                            FontAwesomeIcons.solidComments,
                            size: 20,
                            color: current == 1
                                ? const Color.fromRGBO(142, 112, 79, 1)
                                : const Color.fromRGBO(91, 125, 144, 1),
                          ),
                        ),
                        BottomNavigationBarItem(
                          label: '',
                          icon: FaIcon(
                            FontAwesomeIcons.solidUser,
                            size: 20,
                            color: current == 2
                                ? const Color.fromRGBO(142, 112, 79, 1)
                                : const Color.fromRGBO(91, 125, 144, 1),
                          ),
                        )
                      ],
                      onTap: (value) {
                        setState(() {
                          current = value;
                        });
                      },
                    ),
                  ),
                ))
            : Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.grey.withOpacity(0.8),
              ),
      );
    });
  }
}

class OUT extends StatelessWidget {
  const OUT({
    super.key,
    required this.cx,
  });
  final BuildContext cx;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 100),
      // height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
          color: const Color(0xFF02141F),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    alignment: Alignment.topLeft,
                    onPressed: () {
                      Navigator.pop(cx);
                    },
                    icon: const Icon(Icons.close)),
              ),
            ],
          ),
          /* Container(
            padding: const EdgeInsets.all(50),
            margin: const EdgeInsets.all(15),
            height: 120,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/done.png'))),
          ),*/
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Are you sure you want to Exit",
                  softWrap: true,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFF9F9F9)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                Expanded(
                  child: Builder(builder: (cx) {
                    return InkWell(
                      onTap: () {
                        Navigator.pop(cx);
                      },
                      child: Container(
                          // height: 50,

                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFF8E704F)),
                              color: const Color(0xFF02141F),
                              borderRadius: BorderRadius.circular(70)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              'NO',
                              softWrap: false,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                      color: const Color(0xFF8E704F),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                            ),
                          )),
                    );
                  }),
                ),
                const SizedBox(width: 22),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Platform.isAndroid ? SystemNavigator.pop() : exit(0);
                    },
                    child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(142, 112, 79, 1),
                            borderRadius: BorderRadius.circular(70)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            'YES',
                            softWrap: false,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: const Color(0xFFF9F9F9),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                          ),
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
