import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/groupattach.dart';
import 'package:chatjob/models/mediamodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class DocsScreen extends StatefulWidget {
  const DocsScreen({super.key, required this.id});
  final int id;
  @override
  State<DocsScreen> createState() => _DocsScreenState();
}

class _DocsScreenState extends State<DocsScreen> {
  @override
  void initState() {
    getimages();
    super.initState();
  }

  getimages() async {
    x = await getGroupMedia(groupid: widget.id, type: 'doc');
    setState(() {
      docs = x;
    });
  }

  MediaModel? x, docs;
  @override
  Widget build(BuildContext context) {
    return docs == null
        ? Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
            child: Center(
                child: Lottie.asset('assets/images/JP LOADING.json',
                    height: MediaQuery.of(context).size.width / 1.5,
                    width: MediaQuery.of(context).size.width / 1.5)),
          )
        : docs!.data!.isEmpty
            ? Center(
                child: Text(
                  'No Documents yet',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              )
            : Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 22),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(14),
                        height: 84,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color(0xFF0A2432)),
                        child: Row(
                          children: [
                            const Image(
                                height: 46,
                                width: 37,
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/images/PDF_file_icon 1.png')),
                            const SizedBox(width: 12),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Brand Guidelines.pdf",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFF9F9F9)),
                                ),
                                Text(
                                  "23 MB",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xFFCFCECA)),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 12,
                    ),
                    itemCount: docs!.data!.length,
                  )),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    width: double.infinity,
                    color: const Color(0xFF02141F),
                    child: Text(
                      docs!.data!.length == 1
                          ? '1 document'
                          : "${docs!.data!.length} ${LocaleKeys.groupInfotabsdocsnum.tr()}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFF9F9F9)),
                    ),
                  )
                ],
              );
  }
}
