import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/screens/groupchat/Sharedmediascreens/Docs.dart';
import 'package:chatjob/screens/groupchat/Sharedmediascreens/Links.dart';
import 'package:chatjob/screens/groupchat/Sharedmediascreens/Media.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

class SharedMediaScreen extends StatelessWidget {
  const SharedMediaScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          backgroundColor: const Color(0xFF0A2432),
          title: Text(LocaleKeys.groupInfoMediaLinksandDocs.tr()),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(74),
            child: TabBar(
                dividerHeight: 0,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
                splashFactory: NoSplash.splashFactory,
                labelColor: const Color(0xFF8E704F),
                unselectedLabelColor: const Color(0xFFCFCECA),
                labelStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xFF02141F)),
                tabs: [
                  Tab(
                    text: LocaleKeys.groupInfotabsMedia.tr(),
                  ),
                  /* Tab(
                    text: LocaleKeys.groupInfotabslinks.tr(),
                  ),*/
                  Tab(
                    text: LocaleKeys.groupInfotabsDocs.tr(),
                  ),
                ]),
          ),
        ),
        body: TabBarView(children: [
          MediaScreen(
            id: id,
          ),
          //const LinksScreen(),
          DocsScreen(
            id: id,
          )
        ]),
      ),
    );
  }
}
