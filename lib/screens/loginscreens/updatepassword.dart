import 'package:chatjob/method/network.dart';
import 'package:chatjob/widget/buttonwid.dart';
import 'package:chatjob/widget/textwid.dart';
import 'package:flutter/material.dart';

class Updatepassreen extends StatelessWidget {
  const Updatepassreen({super.key, required this.code, required this.email});
  final String code;
  final String email;

  // bool hidden = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController pass1cont = TextEditingController();

    TextEditingController pass2cont = TextEditingController();
    String? newPass, passconf;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30.0 * 0.8, vertical: 110),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 11),
                      child: Textstack(
                        text: 'Update Password!',
                      ),
                    ),
                    Text(
                        'Enter the password sent to your email patrikbeigun@noubodiez.com',
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontStyle: FontStyle.italic)),
                    const SizedBox(
                      height: 32,
                    ),
                    Customtextfield(
                      /* suficon: InkWell(
                        onTap: () => setState(() {
                          hidden = !hidden;
                        }),
                        child: Icon(
                          hidden ? Icons.visibility : Icons.visibility_off,
                          color: const Color.fromARGB(255, 10, 66, 112),
                        ),
                      ),*/
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Input Your Data';
                        }
                        return null;
                      },
                      hint: 'New Password',
                      controller: pass1cont,
                      onchange: (val) {
                        newPass = val;
                      },
                      obscure: true,
                      nextOrdone: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Customtextfield(
                      /* suficon: InkWell(
                        onTap: () => setState(() {
                          hidden = !hidden;
                        }),
                        child: Icon(
                          hidden ? Icons.visibility : Icons.visibility_off,
                          color: const Color.fromARGB(255, 10, 66, 112),
                        ),
                      ),*/
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Input Your Data';
                        }
                        return null;
                      },
                      obscure: true,
                      hint: 'Confirm New Password',
                      controller: pass2cont,
                      onchange: (val) {
                        passconf = val;
                      },
                      nextOrdone: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Custombuttom(
              onpress: () async {
                if (formKey.currentState!.validate()) {
                  changepass(
                      code: code,
                      pass: newPass!,
                      confpass: passconf!,
                      context: context);
                }
              },
              label: 'Login')
        ],
      ),
    );
  }
}
