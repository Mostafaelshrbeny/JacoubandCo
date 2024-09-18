import 'dart:io';
import 'dart:ui';

import 'package:chatjob/cubits/EditCompany/edit_company_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/company/company_apis_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/company/company_apis_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/screens/AdminScreens/EditCompany.dart';
import 'package:chatjob/screens/mainscreen.dart';
import 'package:chatjob/widget/publicwid.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  @override
  void initState() {
    getComdata();
    super.initState();
  }

  getComdata() async {
    setState(() {
      comnum = pref.getInt('newcomnum');
      comop = pref.getString('newcomshow');
    });
  }

  Color pickerColor = Colors.red;
  int? comnum;
  String? comop, name, cash, desc, web, opensea, discord, instagram, facebook;
  File? imageselected;
  bool? shown;
  var formky = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextStyle styling = Theme.of(context).textTheme.displayLarge!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: const Color(0xFFF9F9F9));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EditCompanyCubit(),
        ),
        BlocProvider(
          create: (context) => CompanyApisCubit(),
        ),
      ],
      child: BlocConsumer<EditCompanyCubit, EditCompanyState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cub = EditCompanyCubit.get(context);
          return Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(LocaleKeys.addCompany.tr()),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              ),
            ),
            body: Form(
              key: formky,
              child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30 * 0.8, vertical: 22),
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
                                      ? const Image(
                                          image: AssetImage(
                                              "assets/images/download.jpg"))
                                      : Image.file(
                                          imageselected!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Text(
                                LocaleKeys.editCoUploadLogo.tr(),
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
                          return 'Enter The Company Name ';
                        }
                        return null;
                      },
                      label: LocaleKeys.editCoCompanyName.tr(),
                      initial: "",
                      onchange: (p0) {
                        name = p0;
                      },
                    ),
                    Editfield(
                      typeIP: TextInputType.number,
                      validate: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Enter The Company Share ';
                        }
                        return null;
                      },
                      label: LocaleKeys.editCoCompanyShare.tr(),
                      initial: "",
                      onchange: (p0) {
                        cash = p0;
                      },
                    ),
                    ChartColor(
                      chartColor: pickerColor,
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => ColorChooseDialog(
                          widget: null,
                          colorChart: pickerColor,
                          change: (value) {
                            setState(() => pickerColor = value);
                            print(value);
                          },
                        ),
                      ),
                      isColor: true,
                      index: null,
                    ),
                    const SizedBox(height: 20),
                    Editfield(
                      label: LocaleKeys.editCoCompanyBio.tr(),
                      maxlines: 4,
                      fontsize: 14,
                      space: 32,
                      initial: '',
                      onchange: (p0) {
                        desc = p0;
                      },
                    ),
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
                                    seleted1: comnum ?? 1,
                                    onchange1: () {
                                      cub.shownewCompany(1);
                                      getComdata();
                                      setState(() {
                                        shown = true;
                                      });
                                      Navigator.pop(context);
                                    },
                                    onchange2: () {
                                      cub.shownewCompany(2);
                                      getComdata();
                                      shown = false;
                                      Navigator.pop(context);
                                    },
                                  );
                                });
                          },
                          child: Row(
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
                              Text(LocaleKeys.showCard.tr(), style: styling),
                              const Spacer(),
                              Text(
                                comop ?? "Shown",
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
                    const SizedBox(height: 32),
                    Text('Website', style: styling),
                    const SizedBox(height: 12),
                    Editfield(
                      label: 'Link',
                      initial: "",
                      onchange: (p0) {
                        web = p0;
                      },
                    ),
                    Text(
                      'OpenSea',
                      style: styling,
                    ),
                    const SizedBox(height: 12),
                    Editfield(
                      label: 'Link',
                      initial: "",
                      onchange: (p0) {
                        opensea = p0;
                      },
                    ),
                    Text('Discord', style: styling),
                    const SizedBox(height: 12),
                    Editfield(
                      label: 'Link',
                      initial: "",
                      onchange: (p0) {
                        discord = p0;
                      },
                    ),
                    Text('Instagram', style: styling),
                    const SizedBox(height: 12),
                    Editfield(
                      label: 'Link',
                      initial: "",
                      onchange: (p0) {
                        instagram = p0;
                      },
                    ),
                    Text('Facebook', style: styling),
                    const SizedBox(height: 12),
                    Editfield(
                      label: 'Link',
                      initial: "",
                      onchange: (p0) {
                        facebook = p0;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<CompanyApisCubit, CompanyApisState>(
                      listener: (context, state) {
                        if (state is Loadingstate) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'loading..',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            backgroundColor: Colors.black.withOpacity(0.7),
                            duration: const Duration(milliseconds: 500),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ));
                        } else if (state is Addedstate) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Mainscreen(
                                        inApp: true,
                                      )));
                        } else if (state is Failedstate) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Something go wrong!!',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            backgroundColor: Colors.black.withOpacity(0.7),
                            duration: const Duration(milliseconds: 500),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ));
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(70),
                            onTap: () async {
                              if (formky.currentState!.validate()) {
                                await BlocProvider.of<CompanyApisCubit>(context)
                                    .createcompany(
                                        color: pickerColor == Colors.red
                                            ? null
                                            : pickerColor.value.toString(),
                                        context: context,
                                        image: imageselected,
                                        name: name!,
                                        cashinbank: double.parse(cash!),
                                        opensea: opensea ?? '',
                                        facebook: facebook ?? '',
                                        discord: discord ?? '',
                                        instagram: instagram ?? '',
                                        website: web ?? '',
                                        category: '',
                                        desc: desc ?? '',
                                        active: shown ?? true);
                              }
                            },
                            child: Container(
                              height: 50 * 0.8,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(142, 112, 79, 1),
                                  borderRadius: BorderRadius.circular(70)),
                              width: MediaQuery.sizeOf(context).width - 20,
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ]),
            ),
          );
        },
      ),
    );
  }

  Future pickimage() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      imageselected = File(pickedimage!.path);
      print(imageselected);
    });
  }
}
