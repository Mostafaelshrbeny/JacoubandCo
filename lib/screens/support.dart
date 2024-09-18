import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/widget/SupportMessage.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

String? username, useremail, usersubject, supmessage;

class _SupportScreenState extends State<SupportScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
              child: SizedBox(
                height: 10,
              )),
          title: Text(
            LocaleKeys.additionalSetSupport.tr(),
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: SupportUserField(
            name: name,
            email: email,
            subject: subject,
            message: message,
            formk: formkey,
          ),
        )),
      ),
    );
  }
}
