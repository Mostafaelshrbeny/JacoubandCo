import 'package:chatjob/cubits/settingsC/settings_cubit.dart';
import 'package:chatjob/cubits/settingsC/settings_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/method/refresh.dart';
import 'package:chatjob/screens/AdminScreens/AddWallpaper.dart';
import 'package:chatjob/screens/AdminScreens/createuser.dart';
import 'package:chatjob/screens/settings/twostepverify/TwoStepOn.dart';

import 'package:chatjob/screens/settings/twostepverify/twostepverify.dart';
import 'package:chatjob/screens/settings/wallpapers.dart';
import 'package:chatjob/widget/publicwid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.admin});
  final bool admin;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    getpref();
    super.initState();
  }

  getpref() async {
    setState(() {
      currancynum = pref.getInt('curr');
      currancytype = pref.getString('curname');
      language = pref.getString('lang');
      langnum = pref.getInt('langnum');
      faceid = pref.getString('face');
      facenum = pref.getInt('facenum');
    });
  }

  String? faceid;
  int? facenum;
  String? language;
  int? currancynum;
  int? langnum;
  String? currancytype;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsCubit(),
          ),
        ],
        child: BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) {},
          builder: (context, state) {
            var scub = SettingsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)),
                ),
                bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(10),
                    child: SizedBox(height: 10)),
                title: Text(LocaleKeys.additionalSetSettings.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w600)),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30 * 0.8, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Settings',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFCFCECA)),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromRGBO(10, 36, 50, 1)),
                      child: AdditionalRow(
                          x: 14,
                          label: LocaleKeys.allsettingsChatWallpaper.tr(),
                          icon: const FaIcon(
                            FontAwesomeIcons.solidImage,
                            size: 18,
                            color: Color(0xFFAECDF8),
                          ),
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const ChnageWallPaperScreen()));
                          }),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      LocaleKeys.allsettingsGeneralSettings.tr(),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFCFCECA)),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromRGBO(10, 36, 50, 1)),
                      child: Column(children: [
                        Builder(builder: (cx) {
                          return SettingsRow(
                            icon1: Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/faceid.png"))),
                            ),
                            label: 'Face ID',
                            info: faceid ?? "",
                            onpress: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor:
                                      const Color.fromARGB(255, 3, 27, 43),
                                  context: cx,
                                  builder: (context) {
                                    return BottomSheetOptions(
                                      seleted1: facenum,
                                      cx: cx,
                                      label: 'Face ID',
                                      onchange1: () {
                                        scub.faceidselect(1);
                                        getpref();
                                        Navigator.pop(context);
                                      },
                                      onchange2: () {
                                        scub.faceidselect(2);
                                        getpref();

                                        Navigator.pop(context);
                                      },
                                      option1:
                                          LocaleKeys.allsettingsfaceOpon.tr(),
                                      option2:
                                          LocaleKeys.allsettingsfaceOpoff.tr(),
                                    );
                                  });
                            },
                          );
                        }),
                        const Padding(
                          padding: EdgeInsets.only(left: 22),
                          child: Divider(),
                        ),
                        SettingsRow(
                          icon1: const FaIcon(
                            FontAwesomeIcons.lock,
                            color: Color(0xFFAECEF8),
                            size: 18,
                          ),
                          label: LocaleKeys.allsettingsTwostepVerification.tr(),
                          info: pref.getString('TwoS')!,
                          onpress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        pref.getString('TwoS') == "ON"
                                            ? TwoStepOnScreen(
                                                admin: widget.admin,
                                              )
                                            : TwoStepScreen(
                                                admin: widget.admin,
                                              )));
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 22),
                          child: Divider(),
                        ),
                        Builder(builder: (cz) {
                          return SettingsRow(
                            icon1: Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/language.png"))),
                            ),
                            label: LocaleKeys.allsettingsLanguage.tr(),
                            info: language ?? "",
                            onpress: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor:
                                      const Color.fromARGB(255, 3, 27, 43),
                                  context: cz,
                                  builder: (context) {
                                    return BottomSheetOptions(
                                      seleted1: langnum,
                                      cx: cz,
                                      label:
                                          LocaleKeys.allsettingsLanguage.tr(),
                                      onchange1: () {
                                        getpref();
                                        scub.langselect(1, context);
                                        Navigator.pop(context);
                                      },
                                      onchange2: () {
                                        getpref();
                                        scub.langselect(2, context);
                                        Navigator.pop(context);
                                        refreshs(context, widget);
                                      },
                                      option1: LocaleKeys.allsettingslangEnglish
                                          .tr(),
                                      option2:
                                          LocaleKeys.allsettingslangCzech.tr(),
                                    );
                                  });
                            },
                          );
                        }),
                        const Padding(
                          padding: EdgeInsets.only(left: 22),
                          child: Divider(),
                        ),
                        Builder(builder: (cy) {
                          return SettingsRow(
                            icon1: const FaIcon(
                              FontAwesomeIcons.moneyBill,
                              color: Color(0xFFAECEF8),
                              size: 18,
                            ),
                            label: LocaleKeys.allsettingsCurrency.tr(),
                            info: currancytype ?? "",
                            onpress: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24))),
                                  backgroundColor:
                                      const Color.fromARGB(255, 3, 27, 43),
                                  context: cy,
                                  builder: (context) {
                                    return BottomSheetOptions(
                                      seleted1: currancynum,
                                      cx: cy,
                                      label:
                                          LocaleKeys.allsettingsCurrency.tr(),
                                      onchange1: () {
                                        getpref();
                                        scub.moneyselect(1);
                                        Navigator.pop(context);
                                        refreshs(context, widget);
                                      },
                                      onchange2: () {
                                        getpref();
                                        scub.moneyselect(2);

                                        Navigator.pop(context);
                                        refreshs(context, widget);
                                      },
                                      onchange3: () {
                                        getpref();
                                        scub.moneyselect(3);

                                        Navigator.pop(context);
                                        refreshs(context, widget);
                                      },
                                      option1: 'Kč',
                                      option2: 'USD',
                                      option3: 'EUR',
                                    );
                                  });
                            },
                          );
                        }),
                      ]),
                    ),
                    const SizedBox(height: 12),
                    widget.admin
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromRGBO(10, 36, 50, 1)),
                            child: AdditionalRow(
                                x: 14,
                                label: LocaleKeys.allsettingsAddWallpapers.tr(),
                                icon: const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/takeimage.png')),
                                ),
                                ontap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const AddWallpaperScreen()));
                                }),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 12),
                    widget.admin
                        ? InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CreateUserScreen())),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: const Color.fromRGBO(10, 36, 50, 1)),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.person_add,
                                    color: Color(0xFFAECEF8),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    context.locale == const Locale('en', 'US')
                                        ? 'Create User'
                                        : 'vytvořit uživatele',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFFAECEF8)),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xFFAECEF8),
                                  )
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.icon1,
    required this.label,
    required this.info,
    required this.onpress,
  });
  final Widget icon1;
  final String label, info;
  final Function() onpress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 13),
            child: icon1,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFAECEF8)),
          ),
          const Spacer(),
          Text(
            info,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFCFCECA)),
          )
        ],
      ),
    );
  }
}
