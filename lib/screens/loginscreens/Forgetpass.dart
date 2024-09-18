import 'package:chatjob/cubits/NetworkCubits/api/api_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/api/api_state.dart';
import 'package:chatjob/method/network.dart';

import 'package:chatjob/screens/loginscreens/verfication.dart';
import 'package:chatjob/widget/buttonwid.dart';
import 'package:chatjob/widget/textwid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  TextEditingController mailcont = TextEditingController();
  String? email;
  var form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocProvider(
          create: (context) => Apicubit(),
          child: BlocConsumer<Apicubit, Apistate>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.all(10),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  ),
                ),
                body: Form(
                  key: form,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0 * 0.8, vertical: 110),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 11),
                                child: Textstack(text: 'Forgot Password!'),
                              ),
                              Text(
                                'Enter your registered email in order to update your current password...',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Customtextfield(
                                typeinput: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Input Your Data';
                                  }
                                  return null;
                                },
                                hint: 'Enter your Email',
                                controller: mailcont,
                                onchange: (val) {
                                  email = val;
                                },
                                obscure: false,
                                nextOrdone: TextInputAction.done,
                              ),
                              const SizedBox(
                                height: 22,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                child: Text(
                                  'Resend in 0.00 sec',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        color:
                                            const Color.fromRGBO(37, 60, 91, 1),
                                      ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Custombuttom(
                          onpress: () {
                            if (form.currentState!.validate()) {
                              forgetpass(email: email!, cx: context);
                            }
                          },
                          label: 'Send Email')
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
