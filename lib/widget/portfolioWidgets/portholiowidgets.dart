import 'package:chatjob/const.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/models/company_model.dart';
import 'package:chatjob/screens/AdminScreens/EditCompany.dart';
import 'package:chatjob/screens/company.dart';
import 'package:chatjob/screens/mainscreens/portfolio.dart';
import 'package:chatjob/widget/ImageWidget.dart';
import 'package:chatjob/widget/textwid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({
    super.key,
    required this.sections,
  });
  final List<PieChartSectionData>? sections;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: widget.sections,
        startDegreeOffset: 270,
        borderData: FlBorderData(show: false),
        centerSpaceRadius: 0,
        sectionsSpace: 1,
      ),
      swapAnimationDuration: const Duration(milliseconds: 200),
      swapAnimationCurve: Curves.bounceIn,
    );
  }
}

class PiechartText extends StatelessWidget {
  const PiechartText({
    super.key,
    required this.text1,
    required this.text2,
  });
  final String text1, text2;
  @override
  Widget build(BuildContext context) {
    return Text(
      text1,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: const Color.fromRGBO(207, 206, 202, 1)),
    );
  }
}

class Iconframe extends StatelessWidget {
  const Iconframe({
    super.key,
    required this.imageurl,
  });
  final String imageurl;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20, left: 14, right: 12),
      height: 36,
      width: 36,
      // padding: const EdgeInsets.all(6),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image(
            image: AssetImage(imageurl),
            fit: BoxFit.cover,
          )),
    );
  }
}

class CashCard extends StatelessWidget {
  const CashCard({
    super.key,
    required this.icon1,
    required this.label,
    this.info,
    this.padd = 30 * 0.8,
    this.size = 18,
    this.weight = FontWeight.w400,
    this.label2,
    this.onpress,
  });
  final Widget icon1;
  final String label;
  final String? info;
  final Widget? label2;
  final Function()? onpress;
  final double padd, size;

  final FontWeight weight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padd),
      child: InkWell(
        splashColor: Colors.black.withOpacity(0),
        focusColor: Colors.black.withOpacity(0),
        hoverColor: Colors.black.withOpacity(0),
        highlightColor: Colors.black.withOpacity(0),
        onTap: onpress,
        child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromRGBO(10, 36, 50, 1),
            ),
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: const EdgeInsets.only(right: 4), child: icon1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: size,
                          fontWeight: weight,
                          color: const Color(0xFFAECDF8)),
                    ),
                    const SizedBox(height: 8),
                    label2 ?? const SizedBox()
                  ],
                ),
                const Spacer(),
                info == null
                    ? const SizedBox()
                    : Text(
                        info!,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF8E704F)),
                      ),
              ],
            )),
      ),
    );
  }
}

class CompaniesList extends StatelessWidget {
  const CompaniesList({
    super.key,
    required this.widget,
    required this.comp,
  });

  final Portfolioscreen widget;
  final List<CompanyModel>? comp;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var z = double.parse(
            double.parse(comp![index].cashInBank!).toStringAsFixed(2));

        return Containtext(
          color: comp![index].color == null
              ? colorArray[index]
              : convertToColor(colorValue: int.parse(comp![index].color!)),
          onpress: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Companyscreen(
                    admin: widget.admin,
                    info: comp![index].id!,
                    cIndex: index,
                  ))),
          leadingtext: comp![index].name!,
          trailingtext: double.parse(comp![index].cashInBank!) > 1000000
              ? ' ${stringHandel(double.parse((z / 1000000).toString().split('.')[0]))}.${(z / 1000000).toStringAsFixed(2).split('.')[1]} M ${pref.getString('curname')}'
              : '${z > 1000 ? (z / 1000).toStringAsFixed(z.toString().length - (z / 1000).toString().split('.')[0].length).replaceAll('.', ',') : z} ${pref.getString('curname')}',
          desc: comp![index].description,
          leadingicon: comp![index].image == null
              ? const Iconframe(imageurl: 'assets/images/download.jpg')
              : ImageWid(
                  imageUrl: comp![index].image!,
                  noImage: 'assets/images/download.jpg',
                  margin: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 14, right: 12),
                  height: 36,
                  width: 36,
                  raduis: 8,
                ),
        );
      },
      itemCount: comp == null ? 0 : comp!.length,
    );
  }
}

stringHandel(double x) {
  final formatter = NumberFormat('#,###');
  return formatter.format(x);
}
