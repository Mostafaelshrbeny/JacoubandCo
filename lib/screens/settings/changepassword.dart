import 'package:chatjob/cubits/NetworkCubits/profile/profile_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/profile/profile_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/widget/textwid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Changepasswordscreen extends StatefulWidget {
  const Changepasswordscreen({super.key});

  @override
  State<Changepasswordscreen> createState() => _ChangepasswordscreenState();
}

class _ChangepasswordscreenState extends State<Changepasswordscreen> {
  TextEditingController con = TextEditingController();
  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();
  String? old, newpass, conf;
  GlobalKey<FormState> formky = GlobalKey<FormState>();
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Profilecubit(),
      child: BlocConsumer<Profilecubit, ProfileState>(
        listener: (context, state) {
          if (state is LoadingPassState) {
            Profilecubit.get(context).loadi(true);
          } else if (state is ChangePassState) {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                context: context,
                builder: (context) {
                  return NewWidget(
                    cx: context,
                  );
                });
          } else if (state is FailedChangeState) {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                context: context,
                builder: (context) {
                  return ErrorWidget(
                    cx: context,
                  );
                });
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              ),
              bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(10),
                  child: SizedBox(height: 10)),
              title: Text(
                LocaleKeys.updatePassword.tr(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFCFCECA)),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
              child: Form(
                key: formky,
                child: Column(
                  children: [
                    Customtextfield(
                      suficon: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () => setState(() {
                          hidden = !hidden;
                        }),
                        child: Icon(
                          hidden ? Icons.visibility : Icons.visibility_off,
                          color: const Color.fromARGB(255, 10, 66, 112),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field Is Required';
                        }
                        return null;
                      },
                      hint: LocaleKeys.passwordOldPassword.tr(),
                      controller: con,
                      onchange: (val) {
                        old = val;
                      },
                      obscure: false,
                      nextOrdone: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Customtextfield(
                      suficon: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () => setState(() {
                          hidden = !hidden;
                        }),
                        child: Icon(
                          hidden ? Icons.visibility : Icons.visibility_off,
                          color: const Color.fromARGB(255, 10, 66, 112),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field Is Required';
                        }
                        return null;
                      },
                      hint: LocaleKeys.passwordNewPassword.tr(),
                      controller: con1,
                      onchange: (val) {
                        newpass = val;
                      },
                      obscure: false,
                      nextOrdone: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Customtextfield(
                      suficon: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () => setState(() {
                          hidden = !hidden;
                        }),
                        child: Icon(
                          hidden ? Icons.visibility : Icons.visibility_off,
                          color: const Color.fromARGB(255, 10, 66, 112),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field Is Required';
                        } else if (newpass != conf) {
                          return 'Not Match';
                        }
                        return null;
                      },
                      hint: LocaleKeys.passwordConfirmNewPassword.tr(),
                      controller: con2,
                      onchange: (val) {
                        conf = val;
                      },
                      obscure: false,
                      nextOrdone: TextInputAction.done,
                    ),
                    const Spacer(),
                    Profilecubit.get(context).load == false
                        ? Builder(builder: (cx) {
                            return InkWell(
                              onTap: () async {
                                if (formky.currentState!.validate()) {
                                  await BlocProvider.of<Profilecubit>(context)
                                      .changepass(
                                          old: old!,
                                          newpass: newpass!,
                                          confirmNew: conf!);
                                }
                              },
                              child: Container(
                                  height: 50,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 22),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(142, 112, 79, 1),
                                      borderRadius: BorderRadius.circular(70)),
                                  width: MediaQuery.sizeOf(context).width - 20,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      LocaleKeys.saveChanges.tr(),
                                      softWrap: false,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                              color: const Color(0xFFCFCECA),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            );
                          })
                        : const CircularProgressIndicator(
                            color: Color(0xFF8E704F),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Alert changeDoneAlert(BuildContext context, Widget content) {
    return Alert(
      context: context,
      style: AlertStyle(
          animationType: AnimationType.grow,
          backgroundColor: const Color(0xFF02141F),
          alertBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
      content: content,
      type: AlertType.none,

      //  desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [],
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.cx,
  });
  final BuildContext cx;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 100),
      decoration: BoxDecoration(
          color: const Color(0xFF02141F),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    alignment: Alignment.topLeft,
                    onPressed: () {
                      Navigator.pop(cx);
                    },
                    icon: const Icon(Icons.close)),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(50),
            margin: const EdgeInsets.all(15),
            height: 120,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/done.png'))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              LocaleKeys.changesareSavedSuccessfully.tr(),
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
    required this.cx,
  });
  final BuildContext cx;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 100),
      decoration: BoxDecoration(
          color: const Color(0xFF02141F),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    alignment: Alignment.topLeft,
                    onPressed: () {
                      Navigator.pop(cx);
                    },
                    icon: const Icon(Icons.close)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Incorrect Old Password',
              softWrap: true,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w400, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
