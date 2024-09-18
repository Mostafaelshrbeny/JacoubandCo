import 'package:chatjob/cubits/NetworkCubits/api/api_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/api/api_state.dart';
import 'package:chatjob/method/network.dart';

import 'package:chatjob/widget/buttonwid.dart';
import 'package:chatjob/widget/textwid.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class Verificationscreen extends StatefulWidget {
  const Verificationscreen({super.key, required this.email});
  final String email;
  @override
  State<Verificationscreen> createState() => _VerificationscreenState();
}

class _VerificationscreenState extends State<Verificationscreen> {
  String? code;
  @override
  Widget build(BuildContext context) {
    // bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return BlocProvider(
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
            body: Stack(
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
                          child: Textstack(text: 'Verify it’s you!'),
                        ),
                        Text(
                          'Enter the code sent to your email to update your password...',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Pinput(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            length: 4,
                            onCompleted: (value) => code = value,
                            defaultPinTheme: PinTheme(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                width: 50,
                                height: 50,
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(17, 44, 59, 1),
                                    borderRadius: BorderRadius.circular(16))),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Custombuttom(
                    onpress: () async {
                      await verifycode(code!, context, widget.email);
                    },
                    label: 'verify')
              ],
            ),
          );
        },
      ),
    );
  }
}
