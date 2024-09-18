import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/main.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

class ImageWid extends StatelessWidget {
  const ImageWid({
    super.key,
    required this.imageUrl,
    this.margin,
    this.pading,
    this.height,
    this.width,
    required this.noImage,
    this.raduis = 16,
    this.fitting = BoxFit.cover,
  });

  final String imageUrl, noImage;
  final EdgeInsetsGeometry? margin, pading;
  final double? height, width, raduis;
  final BoxFit? fitting;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: UniqueKey(),
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        alignment: Alignment.center,
        margin: margin,
        padding: pading,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(raduis!),
          child: FullScreenWidget(
            disposeLevel: DisposeLevel.High,
            child: Image(
              image: imageProvider,
              fit: fitting,
              height: height,
              width: width,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        alignment: Alignment.center,
        margin: margin,
        padding: pading,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image(
            height: height,
            width: width,
            image: AssetImage(noImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
      fadeInDuration: const Duration(milliseconds: 50),
      placeholder: (context, url) => Container(
        alignment: Alignment.center,
        margin: margin,
        padding: pading,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image(
            height: height,
            width: width,
            image: AssetImage(noImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholderFadeInDuration: Duration.zero,
    );
  }
}

class ProfileImagewidget extends StatelessWidget {
  const ProfileImagewidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: UniqueKey(),
      imageUrl: pref.getString('Userimage')!,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        //  backgroundColor: Colors.white,
        backgroundImage: imageProvider,
        radius: 18,
      ),
      errorWidget: (context, url, error) => const CircleAvatar(
        //  backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/images/no profilepic.png'),
        radius: 18,
      ),
      placeholder: (context, url) => const CircleAvatar(
        backgroundImage: AssetImage('assets/images/no profilepic.png'),
        radius: 18,
      ),
      placeholderFadeInDuration: Duration.zero,
    );
  }
}

class InGroupChatImage extends StatelessWidget {
  const InGroupChatImage({
    super.key,
    required this.groupimage,
  });

  final String? groupimage;

  @override
  Widget build(BuildContext context) {
    return groupimage == null
        ? Container(
            // margin: const EdgeInsets.only(right: 17),
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: const Image(
                height: 36,
                width: 36,
                image: AssetImage('assets/images/no imageGroup.png'),
                fit: BoxFit.cover,
              ),
            ),
          )
        : CachedNetworkImage(
            key: UniqueKey(),
            imageUrl: groupimage!,
            imageBuilder: (context, imageProvider) => Container(
              // margin: const EdgeInsets.only(right: 17),
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  height: 36,
                  width: 36,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              // margin: const EdgeInsets.only(right: 17),
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: const Image(
                  height: 36,
                  width: 36,
                  image: AssetImage('assets/images/no imageGroup.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: const Image(
                  height: 36,
                  width: 36,
                  image: AssetImage('assets/images/no imageGroup.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholderFadeInDuration: Duration.zero,
          );
  }
}
