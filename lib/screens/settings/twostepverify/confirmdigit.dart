//import 'dart:js';

import 'package:chatjob/cubits/settingsC/settings_cubit.dart';
import 'package:chatjob/cubits/settingsC/settings_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/refresh.dart';
import 'package:chatjob/screens/settings/twostepverify/TwoStepOn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class ConfirmDigitScreen extends StatelessWidget {
  const ConfirmDigitScreen(
      {super.key, required this.pincode, required this.admin});
  final bool admin;
  final String pincode;

  @override
  Widget build(BuildContext context) {
    String code;
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(10), child: SizedBox(height: 10)),
        centerTitle: true,
        title: Text(LocaleKeys.allsettingsTwostepVerification.tr()),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 4),
                child: Text(
                  LocaleKeys.twoStepPageConfirmPIN.tr(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFFCFCECA)),
                ),
              ),
              const SizedBox(height: 22),
              Builder(builder: (cx) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: BlocProvider(
                    create: (context) => SettingsCubit(),
                    child: BlocConsumer<SettingsCubit, SettingsState>(
                      listener: (context, state) {
                        if (state is LoadingTwostate) {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              context: cx,
                              builder: (cc) {
                                return Container(
                                  padding: const EdgeInsets.only(bottom: 100),
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 3, 27, 43),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(50),
                                        margin: const EdgeInsets.only(top: 100),
                                        height: 120,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/lockpin.png'))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Text(
                                          LocaleKeys
                                              .twoStepPageWaitwhileprocessing
                                              .tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        } else if (state is FailedTwostate) {
                          refreshs(
                              context,
                              ConfirmDigitScreen(
                                admin: admin,
                                pincode: pincode,
                              ));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Some thing went wrong',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ));
                        } else if (state is TwoStepDonestate) {
                          closeandnavi(context);
                        }
                      },
                      builder: (context, state) {
                        return Pinput(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            length: 4,
                            onCompleted: (value) async {
                              value == pincode
                                  ? {
                                      SettingsCubit.get(context)
                                          .twostep(tfa: true, pin: value),
                                    }
                                  : null;
                            },
                            defaultPinTheme: PinTheme(
                                width: 50,
                                height: 50,
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(17, 44, 59, 1),
                                    borderRadius: BorderRadius.circular(16))));
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  closeandnavi(BuildContext cs) {
    Navigator.push(
        cs,
        MaterialPageRoute(
            builder: (_) => TwoStepOnScreen(
                  admin: admin,
                )));
  }
}
 /* Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    length: 4,
                    onCompleted: (value) => code = value,
                    defaultPinTheme: PinTheme(
                        width: 50,
                        height: 50,
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(17, 44, 59, 1),
                            borderRadius: BorderRadius.circular(16))),
                  )*/