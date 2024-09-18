import 'dart:io';

import 'package:chatjob/const.dart';
import 'package:chatjob/generated/locale_keys.g.dart';

import 'package:chatjob/models/wallpaper_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WallPapersList extends StatefulWidget {
  const WallPapersList({
    super.key,
    required this.wallpapers,
  });

  final List<WallpaperModel>? wallpapers;

  @override
  State<WallPapersList> createState() => _WallPapersListState();
}

class _WallPapersListState extends State<WallPapersList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 30 * 0.8, vertical: 10),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wallpaper ${widget.wallpapers![index].id}',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFF9F9F9)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.only(
                    top: 12, left: 12, bottom: 12, right: 22),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(10, 36, 50, 1)),
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: selectedimages
                                  .contains(widget.wallpapers![index].url!)
                              ? Image(
                                  image: FileImage(
                                      File(widget.wallpapers![index].url!)),
                                  fit: BoxFit.cover,
                                )
                              : Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      widget.wallpapers![index].url!))),
                    ),
                    Text(
                      LocaleKeys.uploadimage.tr(),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 22);
        },
        itemCount: widget.wallpapers!.length);
  }

  /* Future pickimage() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      widget.selectedimages
          .add(WallpaperModel.fromJson({'url': pickedimage!.path.toString()}));
      print(widget.selectedimages);
    });
  }*/
}
