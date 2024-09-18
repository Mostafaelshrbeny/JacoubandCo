import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/screens/settings/twostepverify/confirmdigit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CreateDigitScreen extends StatelessWidget {
  const CreateDigitScreen({super.key, required this.admin});
  final bool admin;

  @override
  Widget build(BuildContext context) {
    String code;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(10), child: SizedBox(height: 10)),
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
                  LocaleKeys.twoStepPageCreatea4.tr(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFFCFCECA)),
                ),
              ),
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    length: 4,
                    onCompleted: (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ConfirmDigitScreen(
                                  pincode: value,
                                  admin: admin,
                                ))),
                    defaultPinTheme: PinTheme(
                        width: 50,
                        height: 50,
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(17, 44, 59, 1),
                            borderRadius: BorderRadius.circular(16)))),
              ),
            ],
          ),
        ),
      ),
    );
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