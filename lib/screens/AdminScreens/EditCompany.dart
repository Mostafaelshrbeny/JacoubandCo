import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatjob/const.dart';

import 'package:chatjob/cubits/EditCompany/edit_company_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/company/company_apis_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/company/company_apis_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/models/company_model.dart';
import 'package:chatjob/widget/publicwid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:image_picker/image_picker.dart';

class EditCompanyScreen extends StatefulWidget {
  const EditCompanyScreen({super.key, required this.info, required this.index});
  final CompanyModel info;
  final int index;

  @override
  State<EditCompanyScreen> createState() => _EditCompanyScreenState();
}

class _EditCompanyScreenState extends State<EditCompanyScreen> {
  @override
  void initState() {
    getComdata();

    super.initState();
  }

  getComdata() async {
    setState(() {
      pickerColor = widget.info.color != null
          ? convertToColor(colorValue: int.parse(widget.info.color!))
          : colorArray[widget.index];
      comnum = pref.getInt('comnum');
      // comop = pref.getString('comshow');
      comop = widget.info.active! ? 'Shown' : 'Hide';
    });
  }

  Color pickerColor = Colors.red;
  int? comnum;
  String? comop, name, cash, bio, web, opensea, dis, insta, face;
  File? imageselected;
  bool? show;
  @override
  Widget build(BuildContext context) {
    TextStyle styling = Theme.of(context).textTheme.displayLarge!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: const Color(0xFFF9F9F9));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EditCompanyCubit()),
        BlocProvider(create: (context) => CompanyApisCubit()),
      ],
      child: BlocConsumer<EditCompanyCubit, EditCompanyState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cub = EditCompanyCubit.get(context);
          return Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(LocaleKeys.editCompany.tr()),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              ),
            ),
            body: ListView(
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
                                    ? widget.info.image == null
                                        ? const Image(
                                            image: AssetImage(
                                                "assets/images/download.jpg"))
                                        : CompanyImageNet(widget: widget)
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
                    label: LocaleKeys.editCoCompanyName.tr(),
                    initial: widget.info.name!,
                    onchange: (p0) {
                      name = p0;
                    },
                  ),
                  Editfield(
                    typeIP: TextInputType.number,
                    label: LocaleKeys.editCoCompanyShare.tr(),
                    initial: widget.info.cashInBank!,
                    onchange: (p0) {
                      cash = p0;
                    },
                  ),
                  ChartColor(
                    chartColor: pickerColor,
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => ColorChooseDialog(
                        widget: widget,
                        change: (value) {
                          setState(() => pickerColor = value);
                          print(value);
                        },
                      ),
                    ),
                    isColor: true,
                    index: widget.index,
                  ),
                  const SizedBox(height: 20),
                  Editfield(
                    label: LocaleKeys.editCoCompanyBio.tr(),
                    maxlines: 4,
                    fontsize: 14,
                    space: 32,
                    initial: widget.info.description!,
                    onchange: (p0) {
                      bio = p0;
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
                                  seleted1: comnum,
                                  onchange1: () {
                                    cub.showCompany(1);

                                    getComdata();
                                    setState(() {
                                      show = true;
                                      comop = LocaleKeys.show.tr();
                                    });
                                    Navigator.pop(context);
                                  },
                                  onchange2: () {
                                    cub.showCompany(2);

                                    getComdata();
                                    setState(() {
                                      show = false;
                                      comop = LocaleKeys.hide.tr();
                                    });

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
                              comop ?? "",
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
                    initial: widget.info.website ?? '',
                    onchange: (p0) {
                      web = p0;
                    },
                  ),
                  Text('OpenSea', style: styling),
                  const SizedBox(height: 12),
                  Editfield(
                    label: 'Link',
                    initial: widget.info.openSea ?? '',
                    onchange: (p0) {
                      opensea = p0;
                    },
                  ),
                  Text('Discord', style: styling),
                  const SizedBox(height: 12),
                  Editfield(
                    label: 'Link',
                    initial: widget.info.discord ?? "",
                    onchange: (p0) {
                      dis = p0;
                    },
                  ),
                  Text('Instagram', style: styling),
                  const SizedBox(height: 12),
                  Editfield(
                    label: 'Link',
                    initial: widget.info.instagram ?? "",
                    onchange: (p0) {
                      insta = p0;
                    },
                  ),
                  Text('Facebook', style: styling),
                  const SizedBox(height: 12),
                  Editfield(
                    label: 'Link',
                    initial: widget.info.facebook ?? "",
                    onchange: (p0) {
                      face = p0;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<CompanyApisCubit, CompanyApisState>(
                    listener: (context, state) {
                      if (state is Editedstate) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Edited Successfully',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          backgroundColor: Colors.black,
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
                          onTap: () {
                            BlocProvider.of<CompanyApisCubit>(context)
                                .editcompant(
                                    context: context,
                                    id: widget.info.id!,
                                    image: imageselected,
                                    name: name ?? widget.info.name!,
                                    cashinbank: cash == null
                                        ? double.parse(widget.info.cashInBank!)
                                        : double.parse(cash!),
                                    opensea: opensea ?? widget.info.openSea,
                                    facebook: face ?? widget.info.facebook,
                                    discord: dis ?? widget.info.discord,
                                    instagram: insta ?? widget.info.instagram,
                                    website: web ?? widget.info.website,
                                    category: '',
                                    desc: bio ?? widget.info.description!,
                                    active: show ?? true,
                                    color: pickerColor.value.toString());
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
                              )),
                        ),
                      );
                    },
                  )
                ]),
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

class ColorChooseDialog extends StatelessWidget {
  const ColorChooseDialog({
    super.key,
    required this.widget,
    required this.change,
    this.colorChart,
  });

  final EditCompanyScreen? widget;
  final Function(Color) change;
  final Color? colorChart;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: widget == null
              ? colorChart
              : widget!.info.color != null
                  ? convertToColor(colorValue: int.parse(widget!.info.color!))
                  : colorArray[10],
          onColorChanged: change,
          enableAlpha: false,
          labelTypes: const [],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Got it'),
          onPressed: () {
            //setState(() => currentColor = pickerColor);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class ChartColor extends StatelessWidget {
  const ChartColor({
    super.key,
    required this.chartColor,
    this.onTap,
    required this.isColor,
    required this.index,
  });

  final dynamic chartColor;
  final Function()? onTap;
  final bool isColor;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromRGBO(10, 36, 50, 1)),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isColor
                  ? chartColor
                  : chartColor != null
                      ? convertToColor(colorValue: int.parse(chartColor))
                      : colorArray[index!],
              radius: MediaQuery.of(context).size.width / 25,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 30,
            ),
            Text(
              'Chart Color',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

convertToColor({required int colorValue}) {
  // Convert integer to hexadecimal string
  String hexString = colorValue.toRadixString(16);

  // Format the hexadecimal string
  String formattedHexString = '0xff${hexString.padLeft(6, '0')}';

  // Create a Color object using the formatted hexadecimal string
  Color color = Color(int.parse(formattedHexString));
  return color;
}

class CompanyImageNet extends StatelessWidget {
  const CompanyImageNet({
    super.key,
    required this.widget,
  });

  final EditCompanyScreen widget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.info.image ?? '',
      imageBuilder: (context, imageProvider) => Image(
        image: imageProvider,
        width: 52,
        height: 62,
        fit: BoxFit.cover,
      ),
      placeholder: (context, url) =>
          const Image(image: AssetImage("assets/images/download.jpg")),
      errorWidget: (context, url, error) =>
          const Image(image: AssetImage("assets/images/download.jpg")),
    );
  }
}

class Editfield extends StatelessWidget {
  const Editfield({
    super.key,
    required this.label,
    required this.initial,
    this.maxlines = 1,
    this.fontsize = 16,
    this.weight = FontWeight.w300,
    this.space = 22,
    required this.onchange,
    this.validate,
    this.typeIP,
  });
  final String label, initial;
  final int maxlines;
  final double fontsize, space;
  final FontWeight weight;
  final Function(String)? onchange;
  final String? Function(String?)? validate;
  final TextInputType? typeIP;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: space),
      child: Container(
        padding: const EdgeInsets.only(top: 8, left: 2, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromRGBO(10, 36, 50, 1)),
        child: TextFormField(
          validator: validate,
          onChanged: onchange,
          keyboardType: typeIP,
          maxLines: maxlines,
          showCursor: true,
          initialValue: initial,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              overflow: TextOverflow.ellipsis,
              fontSize: fontsize,
              fontWeight: weight,
              color: const Color(0xFFCFCECA)),
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(10, 36, 50, 1),
              label: Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: const Color(0xFF2F4A6F),
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              contentPadding:
                  const EdgeInsets.only(top: 15, bottom: 8, right: 5, left: 8),
              // border: InputBorder.none,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none))),
        ),
      ),
    );
  }
}
