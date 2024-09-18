import 'dart:convert';
import 'dart:io';

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/Hive/LocalAuth/LocalAuth.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/NetworkCubits/api/api_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/api/api_state.dart';

import 'package:chatjob/method/deviceinfo.dart';

import 'package:chatjob/screens/loginscreens/Forgetpass.dart';
import 'package:chatjob/screens/twolog.dart';

import 'package:chatjob/widget/buttonwid.dart';
import 'package:chatjob/widget/textwid.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

String? devID;

class _LoginscreenState extends State<Loginscreen> {
  @override
  void initState() {
    getid();

    loginbox!.delete('key');
    super.initState();
  }

  getid() async {
    devID = await getDeviceId();
  }

  String? name, password;

  bool hidden = true;
  TextEditingController emailcont = TextEditingController();
  TextEditingController passcont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var formk = GlobalKey<FormState>();
    //bool x = false;
    return BlocProvider(
      // value: BlocProvider.of<Apicubit>(context),
      create: (context) => Apicubit(),
      child: BlocConsumer<Apicubit, Apistate>(
        listener: (context, state) {
          if (state is Loginloading) {
            Apicubit.get(context).loadi(true);
          } else if (state is Loginfailed) {
            loginbox!.get('key') == "TFA_PIN_REQUIRED"
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => LoginTwoStepScreen(
                              name: name!,
                              password: password!,
                            )))
                : showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3.5,
                        //padding: const EdgeInsets.symmetric(vertical: 50),
                        decoration: BoxDecoration(
                            color: const Color(0xFF02141F),
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: Text(
                            loginbox!.get('key'),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                          ),
                        ),
                      );
                    });
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0 * 0.8, vertical: 140),
                      child: Form(
                        key: formk,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 11),
                              child: Textstack(
                                text: 'Login Now!',
                              ),
                            ),
                            Text('Enter your registered email and password...',
                                textAlign: TextAlign.start,
                                softWrap: true,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        fontStyle: FontStyle.italic,
                                        color: const Color(0xFFCFCECA))),
                            const SizedBox(
                              height: 32,
                            ),
                            Customtextfield(
                              typeinput: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Input Your Data';
                                } else {
                                  return null;
                                }
                              },
                              hint: 'Enter your Email',
                              controller: emailcont,
                              onchange: (val) {
                                name = val;
                              },
                              obscure: false,
                              nextOrdone: TextInputAction.next,
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            Customtextfield(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Input Your Data';
                                } else {
                                  return null;
                                }
                              },
                              obscure: hidden,
                              suficon: InkWell(
                                onTap: () => setState(() {
                                  hidden = !hidden;
                                }),
                                child: Icon(
                                  hidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color.fromARGB(255, 10, 66, 112),
                                ),
                              ),
                              typeinput: TextInputType.visiblePassword,
                              hint: 'Password',
                              controller: passcont,
                              onchange: (valu) {
                                password = valu;
                              },
                              nextOrdone: TextInputAction.done,
                            ),
                            const SizedBox(height: 22),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: InkWell(
                                splashColor: Colors.white.withOpacity(0),
                                hoverColor: Colors.black.withOpacity(0),
                                highlightColor: Colors.black.withOpacity(0),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return const Forgetpassword();
                                  }));
                                },
                                child: Text(
                                  'Forgot your password?',
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      decoration: TextDecoration.underline,
                                      color: const Color(0xFFCFCECA),
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            /*  loginbox!.get('key') != null
                                ? Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text(
                                      loginbox!.get('key').toString(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                              color: Colors.red,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                    ),
                                  )
                                : const SizedBox()*/
                          ],
                        ),
                      ),
                    ),
                  ),
                  Apicubit.get(context).load == false
                      ? Custombuttom(
                          onpress: () async {
                            if (formk.currentState!.validate()) {
                              var data = json.encode({
                                "email": name,
                                "password": password!,
                                "device_id": devID!,
                                "device_type":
                                    Platform.isAndroid ? 'android' : 'ios',
                                "device_token":
                                    deviceToken == null || deviceToken!.isEmpty
                                        ? 'Token $password'
                                        : deviceToken
                              });
                              Apicubit.get(context).log(data, context);
                            }
                          },
                          label: 'Login')
                      : const Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 60),
                            child: CircularProgressIndicator(
                              color: Color(0xFF8E704F),
                            ),
                          )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}




/* Align(
                        alignment: Alignment(-1.08, -1.8),
                        child: Image(
                            image:
                                AssetImage('assets/images/Text Element.png'))),*/
