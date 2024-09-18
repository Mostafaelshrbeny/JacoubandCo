import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';

import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/method/users.dart';
import 'package:chatjob/screens/AdminScreens/SupportTickets.dart';
import 'package:chatjob/screens/editprofile.dart';
import 'package:chatjob/screens/loginscreens/login.dart';
import 'package:chatjob/screens/mainscreen.dart';
import 'package:chatjob/screens/settings/settings.dart';
import 'package:chatjob/screens/support.dart';
import 'package:chatjob/widget/ImageWidget.dart';
import 'package:chatjob/widget/infowidgets.dart';
import 'package:chatjob/widget/publicwid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profilscreen extends StatefulWidget {
  const Profilscreen({super.key, required this.admin});
  final bool admin;

  @override
  State<Profilscreen> createState() => _ProfilscreenState();
}

class _ProfilscreenState extends State<Profilscreen> {
  @override
  void initState() {
    getTheProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top + 20,
              horizontal: 30 * 0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Profile',
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 23, right: 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => Editprofilscreen(
                                  user: false,
                                  image: loginbox!.get('User')['image'],
                                  bio: loginbox!.get('User')['bio'] ?? '',
                                  name: loginbox!.get('User')['name'] ?? '',
                                  email: loginbox!.get('User')['email'] ?? '',
                                  location: loginbox!.get('User')['city'] ?? '',
                                  phone: loginbox!.get('User')['phone'] ?? '',
                                )));
                      },
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.editProfile.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.edit,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 32),
              Card(
                color: const Color.fromRGBO(10, 36, 50, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ImageWid(
                      imageUrl: loginbox!.get('User')['image'],
                      noImage: 'assets/images/no profilepic.png',
                      height: 60,
                      width: 60,
                      margin: const EdgeInsets.only(
                          right: 12, left: 14, top: 22, bottom: 22),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pref.getString('UserName') ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: const Color(0xFFF9F9F9),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18)),
                        Container(
                          padding: const EdgeInsets.only(right: 25),
                          child: Text(loginbox!.get('User')['email'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: const Color(0xFFCFCECA),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12)),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text("More Info",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFF9F9F9))),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromRGBO(10, 36, 50, 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoRaw(
                      dataname: LocaleKeys.phone.tr(),
                      data: loginbox!.get('User')['phone'] ?? '00',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Text(LocaleKeys.bio.tr(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFF9F9F9))),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromRGBO(10, 36, 50, 1)),
                child: Text(
                  loginbox!.get('User')['bio'] ?? 'bio',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFCFCECA)),
                ),
              ),
              const SizedBox(height: 22),
              Text(LocaleKeys.additional.tr(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFF9F9F9))),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromRGBO(10, 36, 50, 1)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AdditionalRow(
                          x: 0,
                          label: LocaleKeys.additionalSetSettings.tr(),
                          icon: const Icon(
                            Icons.settings,
                            color: Color(0xFFAECDF8),
                          ),
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SettingsScreen(
                                          admin: widget.admin,
                                        )));
                          }),
                      const Padding(
                        padding: EdgeInsets.only(left: 38),
                        child: Divider(),
                      ),
                      AdditionalRow(
                          x: 0,
                          label: LocaleKeys.additionalSetSupport.tr(),
                          icon: const FaIcon(
                            FontAwesomeIcons.headset,
                            color: Color(0xFFAECDF8),
                          ),
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => widget.admin
                                      ? const SupportTicketsScreen()
                                      : const SupportScreen(),
                                ));
                          })
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: InkWell(
                  onTap: () {
                    pref.clear();
                    setState(() {
                      current = 0;
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const Loginscreen()),
                        (route) => false);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color.fromRGBO(10, 36, 50, 1)),
                    child: Text(
                      'Log Out',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFF80909)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 125,
              )
            ],
          ),
        ),
      ),
    );
  }
}
