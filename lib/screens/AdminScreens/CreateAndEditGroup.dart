import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:chatjob/cubits/EditCard/edit_card_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/GroupData/group_data_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/GroupData/group_data_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/screens/AdminScreens/EditCompany.dart';
import 'package:chatjob/widget/publicwid.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditANDCreateGroup extends StatefulWidget {
  const EditANDCreateGroup(
      {super.key,
      required this.title,
      this.name,
      this.description,
      required this.image,
      required this.create,
      this.id});
  final String? title, image;
  final bool create;
  final String? name, description;
  final int? id;

  @override
  State<EditANDCreateGroup> createState() => _EditANDCreateGroupState();
}

class _EditANDCreateGroupState extends State<EditANDCreateGroup> {
  @override
  void initState() {
    showgroupRef();
    super.initState();
  }

  showgroupRef() async {
    setState(() {
      showg = pref.getInt('gnum');
      showgop = pref.getString('gshow');
      ngshow = pref.getInt('ngnum');
      ngshowop = pref.getString('ngshow');
    });
  }

  int? showg;
  String? showgop;
  int? ngshow;
  String? ngshowop;
  File? imageselected;
  String? name, bio;
  bool loading = false;
  var formk = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EditCardCubit()),
        BlocProvider(create: (context) => GroupDataCubit()),
      ],
      child: BlocConsumer<EditCardCubit, EditCardState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cub = EditCardCubit.get(context);
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              // resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                ),
                title: Text(widget.title!),
                centerTitle: true,
              ),
              body: Form(
                key: formk,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30 * 0.8, vertical: 20),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: InkWell(
                        onTap: () {
                          pickimage();
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(right: 22),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromRGBO(10, 36, 50, 1)),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 52,
                                height: 62,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: imageselected == null
                                      ? widget.create
                                          ? Image(
                                              image: AssetImage(widget.image!))
                                          : widget.image == null
                                              ? const Image(
                                                  image: AssetImage(
                                                      'assets/images/no imageGroup.png'),
                                                  fit: BoxFit.cover,
                                                  width: 52,
                                                  height: 62,
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl: widget.image!,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Image(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    width: 52,
                                                    height: 62,
                                                  ),
                                                  placeholder: (context, url) =>
                                                      const Image(
                                                    image: AssetImage(
                                                        'assets/images/no imageGroup.png'),
                                                    fit: BoxFit.cover,
                                                    width: 52,
                                                    height: 62,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Image(
                                                    image: AssetImage(
                                                        'assets/images/no imageGroup.png'),
                                                    fit: BoxFit.cover,
                                                    width: 52,
                                                    height: 62,
                                                  ),
                                                )
                                      : Image.file(
                                          imageselected!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Text(
                                LocaleKeys.uploadimage.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        color: const Color(0xFF2F4A6F),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                              ),
                              const Spacer(),
                              const FaIcon(
                                FontAwesomeIcons.cloudArrowUp,
                                color: Color(0xFF2F4A6F),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Editfield(
                      validate: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'This Field is Required';
                        } else {
                          return null;
                        }
                      },
                      label: LocaleKeys.groupInfoGroupName.tr(),
                      initial: widget.name ?? '',
                      onchange: (p0) {
                        name = p0;
                      },
                    ),
                    Editfield(
                      label: LocaleKeys.groupInfoDescription.tr(),
                      validate: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'This Field is Required';
                        } else {
                          return null;
                        }
                      },
                      initial: widget.description ?? '',
                      maxlines: 5,
                      onchange: (p0) {
                        bio = p0;
                      },
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: const Color(0xFF0A2432),
                          borderRadius: BorderRadius.circular(16)),
                      child: Builder(builder: (cx) {
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor:
                                    const Color.fromARGB(255, 3, 27, 43),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                context: cx,
                                builder: (context) {
                                  return BottomSheetOptions(
                                    cx: cx,
                                    label: LocaleKeys.showCard.tr(),
                                    option1: LocaleKeys.show.tr(),
                                    option2: LocaleKeys.hide.tr(),
                                    seleted1: widget.title!.contains('Edit')
                                        ? showg ?? 0
                                        : ngshow ?? 0,
                                    onchange1: () {
                                      widget.title!.contains('Edit')
                                          ? cub.showGroup(1)
                                          : cub.newGroupSHOW(1);
                                      showgroupRef();
                                      Navigator.pop(context);
                                    },
                                    onchange2: () {
                                      widget.title!.contains('Edit')
                                          ? cub.showGroup(2)
                                          : cub.newGroupSHOW(2);
                                      showgroupRef();
                                      Navigator.pop(context);
                                    },
                                  );
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    height: 18,
                                    width: 18,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/cardedit.png'))),
                                  ),
                                  Text(
                                    LocaleKeys.showCard.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                            fontSize: 18,
                                            color: const Color(0xFFAECEF8),
                                            fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              //  const Spacer(),
                              Text(
                                widget.title!.contains('Edit')
                                    ? showgop ?? ''
                                    : ngshowop ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: const Color(0xFFCFCECA)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    BlocConsumer<GroupDataCubit, GroupDataState>(
                      listener: (context, state) {
                        if (state is LoadingCreateState ||
                            state is LoadingEditState) {
                          setState(() {
                            loading = true;
                          });
                        } else {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 12),
                          child: loading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: Color.fromRGBO(142, 112, 79, 1)))
                              : InkWell(
                                  borderRadius: BorderRadius.circular(70),
                                  onTap: () {
                                    if (formk.currentState!.validate()) {
                                      widget.create
                                          ? GroupDataCubit.get(context)
                                              .createGroup(
                                                  name: name!,
                                                  cx: context,
                                                  bio: bio!,
                                                  active: true,
                                                  image: imageselected)
                                          : GroupDataCubit.get(context)
                                              .editGroup(
                                                  cx: context,
                                                  name: name ?? widget.name!,
                                                  id: widget.id!,
                                                  bio: bio ??
                                                      widget.description!,
                                                  active: true,
                                                  image: imageselected);
                                    }
                                  },
                                  child: Container(
                                      height: 50,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              142, 112, 79, 1),
                                          borderRadius:
                                              BorderRadius.circular(70)),
                                      width:
                                          MediaQuery.sizeOf(context).width - 20,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Center(
                                        child: Text(
                                          widget.title!.contains('Edit')
                                              ? LocaleKeys.saveChanges.tr()
                                              : LocaleKeys.next.tr(),
                                          softWrap: false,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                  color:
                                                      const Color(0xFFCFCECA),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future pickimage() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    /*  Uri uri = Uri.parse(pickedimage!.path);
    var x = uri.pathSegments.last;*/
    setState(() {
      imageselected = File(pickedimage!.path);
      print(imageselected);
    });
  }
}
