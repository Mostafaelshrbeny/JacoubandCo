import 'package:chatjob/cubits/NetworkCubits/WallpaperData/wallpaper_data_cubit.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/models/wallpaper_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddWallpaperWidget extends StatefulWidget {
  const AddWallpaperWidget({
    super.key,
    required this.selectedimages,
  });
  final List selectedimages;
  @override
  State<AddWallpaperWidget> createState() => _AddWallpaperWidgetState();
}

class _AddWallpaperWidgetState extends State<AddWallpaperWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 22, right: 30, left: 30, bottom: 120),
      decoration: BoxDecoration(
          color: const Color(0xFF0A2432),
          borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          WallpaperDataCubit.get(context).addwallpaperbutton();
        },
        child: Row(
          children: [
            const Icon(
              Icons.add_circle_rounded,
              color: Color(0xFFAECDF8),
            ),
            const SizedBox(width: 4),
            Text(
              LocaleKeys.allsettingsAddWallpaper.tr(),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: const Color(0xFFAECDF8),
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
