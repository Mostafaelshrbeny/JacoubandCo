import 'dart:io';
import 'dart:async';
//import 'dart:typed_data';
//import 'package:carousel_slider/carousel_options.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:chatjob/cubits/NetworkCubits/WallpaperData/wallpaper_data_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/WallpaperData/wallpaper_data_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/wallpaper.dart';
import 'package:chatjob/models/wallpaper_model.dart';
import 'package:chatjob/screens/mainscreen.dart';
import 'package:chatjob/screens/settings/settings.dart';

import 'package:chatjob/widget/publicwid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChnageWallPaperScreen extends StatefulWidget {
  const ChnageWallPaperScreen({super.key});

  @override
  State<ChnageWallPaperScreen> createState() => _ChnageWallPaperScreenState();
}

class _ChnageWallPaperScreenState extends State<ChnageWallPaperScreen> {
  String? imageselected;
  @override
  void initState() {
    getwalpapersShow();
    super.initState();
  }

  getwalpapersShow() async {
    x = await getAvailable();
    setState(() {
      wallpapers = x;
    });
  }

  bool loading = false;
  String? savedUrl;
  int? id;
  List<WallpaperModel>? x, wallpapers;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WallpaperDataCubit(),
      child: Scaffold(
        appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            ),
            title: Text(
              LocaleKeys.allsettingsChatWallpaper.tr(),
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: SizedBox(height: 10))),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30 * 0.8, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.wallpaperChooseWallpaper.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(10, 36, 50, 1)),
                  child: AdditionalRow(
                      x: 14,
                      y: 12,
                      label: LocaleKeys.wallpaperChoosefromCameraRoll.tr(),
                      icon: null,
                      ontap: () async {
                        await pickimage();
                      }),
                ),
                const SizedBox(height: 12),
                wallpapers == null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 100),
                        child: Center(
                          child: Text(
                            'Loading Wallpapers...',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(10, 36, 50, 1)),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              setState(() {
                                savedUrl = wallpapers![index].url!;
                                id = wallpapers![index].id;
                              });
                              print(id);
                            },
                            enableInfiniteScroll: false,
                            height: 500.0,
                          ),
                          items: wallpapers!.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: CachedNetworkImage(
                                          imageUrl: i.url!,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Image(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const Image(
                                            image: AssetImage(
                                                'assets/images/Chat Pattern 01.png'),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              imageselected == null
                                                  ? const Image(
                                                      image: AssetImage(
                                                          'assets/images/Chat Pattern 01.png'))
                                                  : Image.file(
                                                      File(imageselected!),
                                                      fit: BoxFit.cover,
                                                    ),
                                        )));
                              },
                            );
                          }).toList(),
                        ),
                      ),
                BlocConsumer<WallpaperDataCubit, WallpaperDataState>(
                  listener: (context, state) {
                    if (state is LoadingChangeUserState ||
                        state is LoadingCreateState) {
                      setState(() {
                        loading = true;
                      });
                    } else if (state is CreateWallState ||
                        state is ChangeUserWallpaperState) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Done Successfully',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      ));
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(142, 112, 79, 1),
                              ),
                            )
                          : InkWell(
                              borderRadius: BorderRadius.circular(70),
                              onTap: () {
                                imageselected != null
                                    ? WallpaperDataCubit.get(context)
                                        .createWallpaper(
                                            wallpaper: File(imageselected!),
                                            used: true)
                                    : id == null
                                        ? null
                                        : WallpaperDataCubit.get(context)
                                            .changeUserWallpaper(id: id!);
                              },
                              child: Container(
                                  height: 40,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(142, 112, 79, 1),
                                      borderRadius: BorderRadius.circular(70)),
                                  width: MediaQuery.sizeOf(context).width - 20,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickimage() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    /*  Uri uri = Uri.parse(pickedimage!.path);
    var x = uri.pathSegments.last;*/
    setState(() {
      imageselected = pickedimage!.path.toString();
      wallpapers!.add(WallpaperModel.fromJson({'url': imageselected}));
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Uploaded Successfully Check The List',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
    ));
  }
}
