import 'dart:io';

import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/UsersCubit/users_cubit.dart';
import 'package:chatjob/cubits/UsersCubit/users_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/screens/mainscreen.dart';

import 'package:chatjob/widget/edituserwid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  XFile? imageselected;
  String? email, name, password;
  GlobalKey<FormState> formK = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text('Create User'),
      ),
      body: Form(
        key: formK,
        child: ListView(
          padding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 30 * 0.8),
          children: [
            InkWell(
              onTap: () {
                pickimage();
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.only(top: 7, left: 12, bottom: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(10, 36, 50, 1)),
                child: Row(
                  children: [
                    imageselected == null
                        ? Container(
                            width: 66,
                            height: 56,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/no profilepic.png'),
                                    fit: BoxFit.cover)),
                          )
                        : Container(
                            width: 66,
                            height: 56,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: FileImage(File(imageselected!.path)),
                                    fit: BoxFit.cover)),
                          ),
                    Expanded(
                      child: Text(
                        LocaleKeys.uploadyourimage.tr(),
                        // softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                color: const Color(0xFF2F4A6F),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                      ),
                    ),
                    //const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(right: 22),
                      child: FaIcon(
                        FontAwesomeIcons.cloudArrowUp,
                        color: Color(0xFF2F4A6F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Editinfowidget(
                valid: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please enter E-mail';
                  } else {
                    return null;
                  }
                },
                onchange: (p0) {
                  email = p0;
                },
                infolabel: 'E-mail',
                initialval: ''),
            const SizedBox(height: 22),
            Editinfowidget(
                valid: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please enter Name';
                  } else {
                    return null;
                  }
                },
                onchange: (p0) {
                  name = p0;
                },
                infolabel: 'Name',
                initialval: ''),
            const SizedBox(height: 22),
            Editinfowidget(
              valid: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please enter Password';
                } else {
                  return null;
                }
              },
              onchange: (p0) {
                password = p0;
              },
              infolabel: 'password',
              initialval: '',
            ),
            const SizedBox(height: 22),
            BlocProvider(
              create: (context) => UsersCubit(),
              child: BlocConsumer<UsersCubit, UsersState>(
                listener: (context, state) {
                  if (state is LoadCUserState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Loading...",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ));
                  } else if (state is FailedCUserState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Something is wrong",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ));
                  } else if (state is CreatedUserState) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const Mainscreen(
                                  inApp: true,
                                )),
                        (route) => false);
                  }
                },
                builder: (context, state) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(70),
                    onTap: () {
                      if (formK.currentState!.validate()) {
                        UsersCubit.get(context).createUser(
                            email: email!,
                            password: password!,
                            name: name!,
                            image: imageselected);
                      }
                    },
                    child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(142, 112, 79, 1),
                            borderRadius: BorderRadius.circular(70)),
                        width: MediaQuery.sizeOf(context).width - 20,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Create User',
                          softWrap: false,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  color: const Color(0xFFCFCECA),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickimage() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    /*  Uri uri = Uri.parse(pickedimage!.path);
    var x = uri.pathSegments.last;*/
    setState(() {
      imageselected = pickedimage;
      print(imageselected);
    });
  }
}
