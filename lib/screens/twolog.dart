import 'dart:convert';
import 'dart:io';

import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/NetworkCubits/api/api_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/api/api_state.dart';
import 'package:chatjob/screens/loginscreens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class LoginTwoStepScreen extends StatelessWidget {
  const LoginTwoStepScreen(
      {super.key, required this.name, required this.password});
  final String name, password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Apicubit(),
      child: BlocConsumer<Apicubit, Apistate>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Pinput(
                  onCompleted: (value) => Apicubit.get(context).log(
                      json.encode({
                        "email": name,
                        "password": password,
                        "device_id": devID!,
                        "tfa_pin": value,
                        "device_type": Platform.isAndroid ? 'android' : 'ios',
                        "device_token": deviceToken
                      }),
                      context),
                  length: 4,
                  defaultPinTheme: PinTheme(
                      width: 50,
                      height: 50,
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 20),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(17, 44, 59, 1),
                          borderRadius: BorderRadius.circular(16)))),
            ),
          );
        },
      ),
    );
  }
}
