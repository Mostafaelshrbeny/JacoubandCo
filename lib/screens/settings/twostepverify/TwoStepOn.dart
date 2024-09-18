import 'package:chatjob/cubits/settingsC/settings_cubit.dart';
import 'package:chatjob/cubits/settingsC/settings_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/screens/mainscreen.dart';

import 'package:chatjob/screens/settings/twostepverify/enter4digit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TwoStepOnScreen extends StatelessWidget {
  const TwoStepOnScreen({super.key, required this.admin});
  final bool admin;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => const Mainscreen(
                      inApp: true,
                    )),
            (_) => false);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(10), child: SizedBox(height: 10)),
          title: Text(
            LocaleKeys.allsettingsTwostepVerification.tr(),
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const Mainscreen(
                                inApp: true,
                              )),
                      (_) => false);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.twoStepPageTwostepverificationison.tr(),
                softWrap: true,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFFCFCECA)),
              ),
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.only(
                    top: 22, bottom: 22, left: 22, right: 12),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(10, 36, 50, 1),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocProvider(
                      create: (context) => SettingsCubit(),
                      child: BlocConsumer<SettingsCubit, SettingsState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          return InkWell(
                            onTap: () async {
                              await SettingsCubit.get(context)
                                  .twostep(tfa: false);
                              current = 2;
                              if (context.mounted) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const Mainscreen(
                                              inApp: true,
                                            )),
                                    (route) => false);
                              }
                            },
                            child: Row(
                              children: [
                                Text(
                                  LocaleKeys.twoStepPageTurnOFF.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                          color: const Color(0xFFF80909),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                ),
                                const Spacer(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CreateDigitScreen(
                                      admin: admin,
                                    )));
                      },
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.twoStepPageChangePIN.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFFCFCECA)),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Color(0xFFAECEF8),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
