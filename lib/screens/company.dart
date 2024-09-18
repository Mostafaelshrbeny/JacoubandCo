import 'package:chatjob/const.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/method/company.dart';
import 'package:chatjob/models/company_model.dart';
import 'package:chatjob/screens/AdminScreens/EditCompany.dart';

import 'package:chatjob/widget/ImageWidget.dart';
import 'package:chatjob/widget/companyWidgets.dart';
import 'package:chatjob/widget/companyinfo.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:url_launcher/url_launcher.dart';

class Companyscreen extends StatefulWidget {
  const Companyscreen(
      {super.key,
      required this.admin,
      required this.info,
      required this.cIndex});
  final bool admin;
  final int info;
  final int cIndex;

  @override
  State<Companyscreen> createState() => _CompanyscreenState();
}

class _CompanyscreenState extends State<Companyscreen> {
  CompanyModel? x, company;
  getthecompany() async {
    x = await getcompany(widget.info);
    setState(() {
      company = x;
    });
  }

  @override
  void initState() {
    getthecompany();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
      ),
      body: company == null
          ? Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
              child: Center(
                  child: Lottie.asset('assets/images/JP LOADING.json',
                      height: MediaQuery.of(context).size.width / 1.5,
                      width: MediaQuery.of(context).size.width / 1.5)),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30 * 0.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: company!.image == null
                            ? Container(
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(
                                  top: 14,
                                ),
                                height: 129,
                                width: 129,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/download.jpg'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              )
                            : ImageWid(
                                imageUrl: company!.image!,
                                noImage: 'assets/images/download.jpg',
                                height: 109,
                                width: 109,
                                pading: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(top: 14),
                              ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        company!.name ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: const Color(0xFFF9F9F9)),
                      ),
                      const SizedBox(height: 12),
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: double.parse(
                                        double.parse(company!.cashInBank!)
                                            .toStringAsFixed(2)) >
                                    1000000
                                ? (double.parse(
                                            double.parse(company!.cashInBank!)
                                                .toStringAsFixed(2)) /
                                        100000)
                                    .toString()
                                    .split('.')
                                    .first
                                : double.parse(double.parse(company!.cashInBank!).toStringAsFixed(2))
                                        .toString()
                                        .contains('.')
                                    ? double.parse(
                                            double.parse(company!.cashInBank!)
                                                .toStringAsFixed(2))
                                        .toString()
                                        .split('.')
                                        .first
                                    : company!.cashInBank!,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 36,
                                    color: const Color(0xFFF9F9F9)),
                          ),
                          TextSpan(
                            text: double.parse(company!.cashInBank!) > 1000000
                                ? '.${(double.parse(company!.cashInBank!) / 1000000).toStringAsFixed(2).split('.').last}'
                                : company!.cashInBank!.toString().contains('.')
                                    ? ".${double.parse(company!.cashInBank!).toStringAsFixed(2).split('.').last}"
                                    : ".00",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 36,
                                    color: const Color.fromRGBO(25, 53, 69, 1)),
                          ),
                          TextSpan(
                            text: double.parse(company!.cashInBank!) > 1000000
                                ? ' M ${pref.getString('curname')}'
                                : " ${pref.getString('curname')}",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 36,
                                    color: const Color(0xFFF9F9F9)),
                          )
                        ]),
                      ),
                      const SizedBox(height: 32),
                      ChartColor(
                        chartColor: company!.color,
                        onTap: () => widget.admin
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EditCompanyScreen(
                                          info: company!,
                                          index: widget.cIndex,
                                        )))
                            : null,
                        isColor: false,
                        index: widget.cIndex,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromRGBO(10, 36, 50, 1)),
                        child: Text(
                          company!.description! == ''
                              ? 'No bio'
                              : company!.description!,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 12, top: 12, bottom: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromRGBO(10, 36, 50, 1)),
                        child: Column(
                          children: [
                            Companyinfo(
                              imagelink: 'assets/images/website.png',
                              label: 'Website',
                              onprees: () async {
                                launchUrlMethod(link: company!.website);
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 12, left: 36),
                              child: Divider(
                                thickness: 1,
                                color: Color.fromRGBO(37, 60, 91, 1),
                              ),
                            ),
                            Companyinfo(
                              imagelink:
                                  'assets/images/Logomark-Blue 1 (1).png',
                              label: 'OpenSea',
                              onprees: () async {
                                launchUrlMethod(link: company!.openSea);
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 12, left: 36),
                              child: Divider(
                                thickness: 1,
                                color: Color.fromRGBO(37, 60, 91, 1),
                              ),
                            ),
                            Companyinfo(
                              imagelink:
                                  'assets/images/Instagram_logo_2016 1 (1).png',
                              label: 'Instagram',
                              onprees: () async {
                                launchUrlMethod(link: company!.instagram);
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 12, left: 36),
                              child: Divider(
                                thickness: 1,
                                color: Color.fromRGBO(37, 60, 91, 1),
                              ),
                            ),
                            Companyinfo(
                              imagelink:
                                  'assets/images/facebook-icon-512x512-seb542ju 1 (1).png',
                              label: 'Facebook',
                              onprees: () async {
                                launchUrlMethod(link: company!.facebook);
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 12, left: 36),
                              child: Divider(
                                thickness: 1,
                                color: Color.fromRGBO(37, 60, 91, 1),
                              ),
                            ),
                            Companyinfo(
                              imagelink:
                                  'assets/images/discord-logo-discord-icon-transparent-free-png 2 (1).png',
                              label: 'Discord',
                              onprees: () async {
                                launchUrlMethod(link: company!.discord);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 110,
                      ),
                    ],
                  ),
                )),
                widget.admin
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 30 * 0.8),
                          child: EditCompany(
                            company: company!,
                            index: widget.cIndex,
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
    );
  }

  launchUrlMethod({required String? link}) async {
    try {
      if (link != null) {
        await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'No Link Yet',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          backgroundColor: Colors.black.withOpacity(0.8),
          duration: const Duration(milliseconds: 500),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ));
      }
    }
  }
}
