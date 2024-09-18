import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/screens/settings/twostepverify/enter4digit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TwoStepScreen extends StatelessWidget {
  const TwoStepScreen({super.key, required this.admin});
  final bool admin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(10), child: SizedBox(height: 10)),
        title: Text(
          LocaleKeys.allsettingsTwostepVerification.tr(),
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
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
              LocaleKeys.twoStepPageCreateaPIN.tr(),
              softWrap: true,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFFCFCECA)),
            ),
            const SizedBox(height: 22),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateDigitScreen(
                        admin: admin,
                      ),
                    ));
              },
              child: Container(
                padding: const EdgeInsetsDirectional.all(24),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(10, 36, 50, 1),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.twoStepPageTurnON.tr(),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFAECEF8)),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFFAECEF8),
                      size: 18,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
