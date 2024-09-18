import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';

import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/method/cashinbank.dart';
import 'package:chatjob/method/network.dart';
import 'package:chatjob/models/cashmodel.dart';
import 'package:chatjob/models/company_model.dart';
import 'package:chatjob/screens/AdminScreens/AddCompany.dart';
import 'package:chatjob/screens/AdminScreens/EditCompany.dart';
import 'package:chatjob/screens/AdminScreens/editcard.dart';
import 'package:chatjob/screens/mainscreens/chats.dart';
import 'package:chatjob/widget/portfolioWidgets/portholiowidgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Portfolioscreen extends StatefulWidget {
  const Portfolioscreen({super.key, required this.admin});
  final bool admin;
  @override
  State<Portfolioscreen> createState() => _PortfolioscreenState();
}

class _PortfolioscreenState extends State<Portfolioscreen> {
  String? name;

  @override
  void initState() {
    getAllcompanies();
    name = pref.getString('UserName');
    super.initState();
  }

  getAllcompanies() async {
    z = await getCash();
    y = await getcompanies(loginbox!.get('token'));
    if (mounted) {
      setState(() {
        comp = y;
        cashVal = z;
        shown = z![1].value == 'true';
      });
    }
    for (var element in y!) {
      allcash += double.parse(element.cashInBank!);
    }

    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => setState(() {
              sections = setSections(cash: allcash, company: comp);
            }));
  }

  @override
  void dispose() {
    getAllcompanies();
    super.dispose();
  }

  var ran = Random();
  List<CompanyModel>? comp, y;
  //double cashinbank = 0;
  List<CashModel>? z, cashVal;
  List<PieChartSectionData>? sections;
  double allcash = 1;
  bool shown = false;
  double degrees = 90;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          ProfileRow(name: name, notiNum: pref.getInt('Notification')!),
          const SizedBox(height: 32),
          Text(
            'Portfolio',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 22,
                color: const Color.fromRGBO(207, 206, 202, 1),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 174,
            height: 174,
            child: sections == null || cashVal![0].value == '0' || allcash == 0
                ? const NewWidget(
                    degree: 270,
                  )
                : PieChartWidget(
                    sections: sections,
                  ),
          ),
          const SizedBox(height: 20),
          sections == null || cashVal![0].value == '0' || allcash == 0
              ? const SizedBox()
              : PercentIndicator(comp: comp, y: y, allcash: allcash),
          // const SizedBox(height: 5),
          widget.admin
              ? InkWell(
                  splashColor: Colors.black.withOpacity(0),
                  focusColor: Colors.black.withOpacity(0),
                  hoverColor: Colors.black.withOpacity(0),
                  highlightColor: Colors.black.withOpacity(0),
                  onTap: () {
                    cashVal == null
                        ? null
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EditCardScreen(
                                      cash: double.parse(cashVal![0].value!),
                                      show: z![1].value == 'true',
                                    )));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromRGBO(10, 36, 50, 1),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 30 * 0.8),
                    child: Text(
                        cashVal == null
                            ? '0.0 M Kč'
                            : double.parse(cashVal![0].value!) > 1000000
                                ? '${(double.parse(cashVal![0].value!) / 1000000).toStringAsFixed(2)} M ${pref.getString('curname')}'
                                : '${double.parse(cashVal![0].value!)} ${pref.getString('curname')}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 38,
                                color: const Color.fromRGBO(142, 112, 79, 1),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w900)),
                  ))
              : const SizedBox(),
          //  widget.admin
          //       ? CashCardInfo(cashVal: cashVal, widget: widget, z: z)
          //       : const SizedBox(),
          Padding(
            padding: const EdgeInsets.only(
                left: 30 * 0.8, right: 30 * 0.8, top: 0, bottom: 60),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Text(
                //   LocaleKeys.allCompanies.tr(),
                //   style: Theme.of(context)
                //       .textTheme
                //       .displayLarge!
                //       .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                // ),
                widget.admin
                    ? CashCard(
                        onpress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AddCompanyScreen())),
                        padd: 0,
                        icon1: const Icon(
                          Icons.add_circle_rounded,
                          color: Color(0xFFAECDF8),
                        ),
                        size: 16,
                        weight: FontWeight.w500,
                        label: LocaleKeys.addCompany.tr())
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                comp == null
                    ? Text(
                        'Loading Companies..',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      )
                    : comp!.isEmpty
                        ? Text(
                            'No Companies to show',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayLarge,
                          )
                        : CompaniesList(widget: widget, comp: comp),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> setSections(
      {required double cash, required List<CompanyModel>? company}) {
    // List z = y!.reversed.toList();
    setState(() {});
    return List.generate(
      y!.length,
      (index) => PieChartSectionData(
        badgePositionPercentageOffset: 0.65,
        badgeWidget: const Padding(
          //padding: EdgeInsets.only(left: 60 * index.toDouble(), top: 50),
          padding: EdgeInsets.only(top: 0),
          child: PiechartText(
            text1: "",
            text2: "",
          ),
        ),
        // titlePositionPercentageOffset: index.toDouble() + 1.5,
        color: company![index].color == null
            ? colorArray[index]
            : convertToColor(colorValue: int.parse(company[index].color!)),
        value: 250 - index * 30,
        showTitle: false,
        //  title: '75% \n meta academy',
        radius: 100 - (index * 5),
      ),
    );
  }
}

class PercentIndicator extends StatelessWidget {
  const PercentIndicator({
    super.key,
    required this.comp,
    required this.y,
    required this.allcash,
  });

  final List<CompanyModel>? comp;
  final List<CompanyModel>? y;
  final double allcash;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 12),
      height: MediaQuery.of(context).size.height / 10,
      width: double.infinity,
      child: GridView.builder(
        itemCount: comp!.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 10),
        shrinkWrap: true,
        itemBuilder: (context, index) => Row(
          children: [
            CircleAvatar(
              backgroundColor: comp![index].color == null
                  ? colorArray[index]
                  : convertToColor(colorValue: int.parse(comp![index].color!)),
              radius: MediaQuery.of(context).size.width / 88,
            ),
            SizedBox(width: MediaQuery.of(context).size.width / 65),
            Text(
              "${((double.parse(y![index].cashInBank!) / allcash) * 100).toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.degree,
  });
  final double degree;
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(startDegreeOffset: degree, sections: [
        PieChartSectionData(
          badgePositionPercentageOffset: 0.9,
          color: colorArray[0],
          value: 800,
          showTitle: false,
          radius: 100,
        ),
        PieChartSectionData(
          badgePositionPercentageOffset: 0.9,
          color: colorArray[1],
          value: 200,
          showTitle: false,
          radius: 90,
        ),
        PieChartSectionData(
          badgePositionPercentageOffset: 0.9,
          color: colorArray[2],
          value: 140,
          showTitle: false,
          radius: 80,
        ),
        PieChartSectionData(
          badgePositionPercentageOffset: 0.9,
          color: colorArray[3],
          value: 100,
          showTitle: false,
          radius: 70,
        ),
      ]),
      swapAnimationDuration: const Duration(seconds: 4),
      swapAnimationCurve: Curves.bounceIn,
    );
  }
}

class CashCardInfo extends StatelessWidget {
  const CashCardInfo({
    super.key,
    required this.cashVal,
    required this.widget,
    required this.z,
  });

  final List<CashModel>? cashVal;
  final Portfolioscreen widget;
  final List<CashModel>? z;

  @override
  Widget build(BuildContext context) {
    return CashCard(
      info: cashVal == null
          ? '0.0 MKč'
          : double.parse(cashVal![0].value!) > 1000000
              ? '${(double.parse(cashVal![0].value!) / 1000000).toStringAsFixed(2)} M ${pref.getString('curname')}'
              : '${double.parse(cashVal![0].value!)} ${pref.getString('curname')}',
      icon1: widget.admin
          ? const SizedBox()
          : Container(
              height: 24,
              width: 24,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/coins.gif'))),
            ),
      label: LocaleKeys.cashinBank.tr(),
      onpress: widget.admin
          ? () => cashVal == null
              ? null
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditCardScreen(
                            cash: double.parse(cashVal![0].value!),
                            show: z![1].value == 'true',
                          )))
          : null,
      label2: widget.admin
          ? Row(
              children: [
                Text(
                  LocaleKeys.editCash.tr(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: const Color(0xFFF9F9F9),
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.edit,
                  size: 12,
                )
              ],
            )
          : const SizedBox(),
    );
  }
}
