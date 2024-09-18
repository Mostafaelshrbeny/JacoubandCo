import 'package:cached_network_image/cached_network_image.dart';

import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/groupattach.dart';
import 'package:chatjob/models/mediamodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:lottie/lottie.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key, required this.id});
  final int id;

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  @override
  void initState() {
    getimages();
    super.initState();
  }

  getimages() async {
    x = await getGroupMedia(groupid: widget.id, type: 'media');
    setState(() {
      images = x;
    });
  }

  MediaModel? x, images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: images == null
          ? Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
              child: Center(
                  child: Lottie.asset('assets/images/JP LOADING.json',
                      height: MediaQuery.of(context).size.width / 1.5,
                      width: MediaQuery.of(context).size.width / 1.5)),
            )
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisExtent: 100,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 5,
                            childAspectRatio: 3 / 3),
                    itemBuilder: (context, index) {
                      return SharedNetworkMedia(
                        images: images,
                        index: index,
                      );
                    },
                    itemCount: images!.data!.length,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  width: double.infinity,
                  color: const Color(0xFF02141F),
                  child: Text(
                    '${images!.data!.length} ${LocaleKeys.groupInfotabsmedianum.tr()}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFF9F9F9)),
                  ),
                )
              ],
            ),
    );
  }
}

class SharedNetworkMedia extends StatelessWidget {
  const SharedNetworkMedia({
    super.key,
    required this.images,
    required this.index,
  });

  final MediaModel? images;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: UniqueKey(),
      imageUrl: images!.data![index].url!,
      imageBuilder: (context, imageProvider) => FullScreenWidget(
        disposeLevel: DisposeLevel.High,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
              image: AssetImage('assets/images/Mask group.png'),
              fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
              image: AssetImage('assets/images/Mask group.png'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
