import 'package:chatjob/cubits/NetworkCubits/SupportMessage/support_message_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/SupportMessage/support_message_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/screens/support.dart';
import 'package:chatjob/widget/textwid.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupportUserField extends StatelessWidget {
  const SupportUserField({
    super.key,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.formk,
  });

  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController subject;
  final TextEditingController message;
  final GlobalKey<FormState> formk;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formk,
      child: Column(children: [
        Text(
          'Type your message here, and one of our associates will reply shortly...',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: const Color(0xFFCFCECA)),
        ),
        const SizedBox(height: 22),
        Customtextfield(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Input Your Data';
            }
            return null;
          },
          hint: LocaleKeys.supportUserPageName.tr(),
          controller: name,
          onchange: (val) {
            username = val;
          },
          obscure: false,
          nextOrdone: TextInputAction.next,
        ),
        const SizedBox(height: 22),
        Customtextfield(
          typeinput: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Input Your Data';
            }
            return null;
          },
          hint: LocaleKeys.supportUserPageEmail.tr(),
          controller: email,
          onchange: (val) {
            useremail = val;
          },
          obscure: false,
          nextOrdone: TextInputAction.next,
        ),
        const SizedBox(height: 22),
        Customtextfield(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Input Your Data';
            }
            return null;
          },
          hint: LocaleKeys.supportUserPageSubject.tr(),
          controller: subject,
          onchange: (val) {
            usersubject = val;
          },
          obscure: false,
          nextOrdone: TextInputAction.next,
        ),
        const SizedBox(height: 32),
        Customtextfield(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Input Your Data';
            }
            return null;
          },
          hint: LocaleKeys.supportUserPageTypeYourMessage.tr(),
          controller: message,
          onchange: (val) {
            supmessage = val;
          },
          obscure: false,
          lines: 6,
          nextOrdone: TextInputAction.done,
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 5),
        BlocProvider(
          create: (context) => SupportMessageCubit(),
          child: BlocConsumer<SupportMessageCubit, SupportMessageState>(
            listener: (context, state) {
              if (state is CreatedSupState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(milliseconds: 500),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    content: Text(
                      'Sent',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    backgroundColor: Colors.black.withOpacity(0.5)));
              }
            },
            builder: (context, state) {
              return InkWell(
                borderRadius: BorderRadius.circular(70),
                onTap: () {
                  if (formk.currentState!.validate()) {
                    SupportMessageCubit.get(context).createSupMessage(
                        subject: usersubject!, body: supmessage!);
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(142, 112, 79, 1),
                        borderRadius: BorderRadius.circular(70)),
                    width: MediaQuery.sizeOf(context).width - 20,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      LocaleKeys.supportUserPageSendMessage.tr(),
                      softWrap: false,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFCFCECA)),
                    )),
              );
            },
          ),
        ),
      ]),
    );
  }
}
