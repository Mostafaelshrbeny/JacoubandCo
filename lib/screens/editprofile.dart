import 'dart:io';

import 'package:chatjob/cubits/NetworkCubits/profile/profile_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/profile/profile_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/screens/groupchat/groupinfo.dart';
import 'package:chatjob/screens/mainscreen.dart';

import 'package:chatjob/screens/settings/changepassword.dart';
import 'package:chatjob/widget/ImageWidget.dart';
import 'package:chatjob/widget/edituserwid.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Editprofilscreen extends StatefulWidget {
  const Editprofilscreen({
    super.key,
    required this.user,
    required this.image,
    required this.bio,
    required this.name,
    required this.email,
    required this.location,
    required this.phone,
    this.id,
    this.gid,
    this.admin,
  });
  final bool user;
  final bool? admin;
  final int? id, gid;
  final String bio, name, email, location, phone;
  final String? image;
  @override
  State<Editprofilscreen> createState() => _EditprofilscreenState();
}

class _EditprofilscreenState extends State<Editprofilscreen> {
  List x = [
    "South Moravia, Czech Republic",
    "South Moravia,2 Czech Republic",
    "South Moravia,3 Czech Republic",
    "South Moravia,4 Czech Republic"
  ];

  String? init;
  XFile? imageselected;
  String? bio;
  String? email;
  String? name;
  String? phone;
  String? city;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Profilecubit(),
        child: BlocConsumer<Profilecubit, ProfileState>(
          listener: (context, state) {
            if (state is LoadingState) {
              setState(() {
                loading = true;
              });
            } else if (state is Editprofilstate) {
              setState(() {
                loading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Updating Done",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                backgroundColor: Colors.black.withOpacity(0.7),
                duration: const Duration(milliseconds: 500),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ));
            } else if (state is Failedloginstate) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Something is wrong",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                backgroundColor: Colors.black.withOpacity(0.7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ));
            } else if (state is DeleteUserState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => GroupInfoScreen(
                            id: widget.gid!,
                            admin: widget.admin!,
                          )));
            } else if (state is LoadingDeleteUserState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Loading..",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                backgroundColor: Colors.black.withOpacity(0.7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ));
            } else if (state is FailedDeleteUserState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Something is wrong",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                backgroundColor: Colors.black.withOpacity(0.7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ));
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                //resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  title: Text(
                    widget.user
                        ? LocaleKeys.editUser.tr()
                        : LocaleKeys.editProfile.tr(),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFF9F9F9)),
                  ),
                  centerTitle: true,
                ),
                body: ListView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 30 * 0.8),
                  children: [
                    InkWell(
                      onTap: () {
                        pickimage();
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 7, left: 12, bottom: 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromRGBO(10, 36, 50, 1)),
                        child: Row(
                          children: [
                            widget.image == null
                                ? Container(
                                    width: 66,
                                    height: 56,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/no profilepic.png'))),
                                  )
                                : imageselected == null
                                    ? ImageWid(
                                        imageUrl: widget.image!,
                                        noImage:
                                            'assets/images/no profilepic.png',
                                        height: 56,
                                        width: 66,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                      )
                                    : Container(
                                        width: 66,
                                        height: 56,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: FileImage(
                                                    File(imageselected!.path)),
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
                        onchange: (p0) {
                          email = p0;
                        },
                        infolabel: LocaleKeys.updateyourEmail.tr(),
                        initialval: widget.email),
                    const SizedBox(height: 22),
                    Editinfowidget(
                        onchange: (p0) {
                          phone = p0;
                        },
                        infolabel: LocaleKeys.updateyourPhoneNumber.tr(),
                        initialval: phone ?? widget.phone),
                    const SizedBox(height: 22),

                    Editinfowidget(
                        onchange: (p0) {
                          bio = p0;
                        },
                        max: 5,
                        infolabel: LocaleKeys.updateyourBio.tr(),
                        initialval: widget.bio),
                    widget.user
                        ? DeleteUserWidget(
                            id: widget.id!,
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 70,
                    ),
                    //patch method
                    InkWell(
                      borderRadius: BorderRadius.circular(70),
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        widget.user
                            ? Profilecubit.get(context).edituser(
                                image: imageselected,
                                name: name ?? widget.name,
                                bio: bio ?? widget.bio,
                                phone: phone ?? widget.phone,
                                city: city ?? widget.location,
                                id: widget.id!)
                            : Profilecubit.get(context).editprofile(
                                image: imageselected,
                                name: name ?? widget.name,
                                bio: bio ?? widget.bio,
                                phone: phone ?? widget.phone,
                                city: city ?? widget.location);
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
                          child: loading
                              ? CircularProgressIndicator(
                                  color: Colors.black.withOpacity(0.8),
                                )
                              : Text(
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
                                )),
                    ),
                    const SizedBox(height: 24),
                    widget.user
                        ? const SizedBox()
                        : InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const Changepasswordscreen())),
                            child: Text(
                              LocaleKeys.updateyourPassword.tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                      color: const Color(0xFFCFCECA)),
                            ),
                          ),
                    SizedBox(
                      height: widget.user ? 31 : 60,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
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
