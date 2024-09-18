import 'package:chatjob/const.dart';

import 'package:chatjob/cubits/NetworkCubits/WallpaperData/wallpaper_data_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/WallpaperData/wallpaper_data_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/wallpaper.dart';

import 'package:chatjob/widget/WallpaperWidgets/AddWallpaperWid.dart';
import 'package:chatjob/widget/WallpaperWidgets/wallpaperwidget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddWallpaperScreen extends StatefulWidget {
  const AddWallpaperScreen({super.key});

  @override
  State<AddWallpaperScreen> createState() => _AddWallpaperScreenState();
}

class _AddWallpaperScreenState extends State<AddWallpaperScreen> {
  @override
  void initState() {
    getAllWallpapers();
    super.initState();
  }

  getAllWallpapers() async {
    x = await getWallpapers();

    setState(() {
      wallpapers = x;
    });
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WallpaperDataCubit(),
      child: BlocConsumer<WallpaperDataCubit, WallpaperDataState>(
        listener: (context, state) {
          if (state is LoadingAdminCreateState) {
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
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              ),
              title: Text(LocaleKeys.allsettingsAddWallpaper.tr()),
              centerTitle: true,
            ),
            body: wallpapers == null
                ? Center(
                    child: Text(
                      'Loading Wallpapers...',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  )
                : Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            WallPapersList(
                              wallpapers: wallpapers,
                            ),
                            AddWallpaperWidget(
                              selectedimages: selectedimages,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30 * 0.8, vertical: 55),
                          child: loading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: Color.fromRGBO(142, 112, 79, 1)),
                                )
                              : InkWell(
                                  onTap: () {
                                    WallpaperDataCubit.get(context)
                                        .savechanges();
                                  },
                                  child: Container(
                                      height: 40,
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
                                          LocaleKeys.saveChanges.tr(),
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
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
