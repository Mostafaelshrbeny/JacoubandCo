import 'dart:io';
import 'dart:typed_data';

import 'package:chatjob/cubits/comments/comments_cubit.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/groupposts.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:popover/popover.dart';

class MessageInputWidget extends StatefulWidget {
  const MessageInputWidget({
    super.key,
    required this.contr,
    required this.cub,
    required this.refresh,
    required this.id,
  });

  final TextEditingController contr;
  final CommentsCubit cub;
  final Function() refresh;
  final int id;

  @override
  State<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  bool loading = false;
  dynamic xdoc;
  File? doc;
  XFile? cameraimage;
  String? body;
  List<String> tags = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        doc == null && cameraimage == null && loading == false
            ? const SizedBox()
            : doc == null
                ? Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Color(0xFF112C3B)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  doc = null;
                                  cameraimage = null;
                                  img = null;
                                });
                              },
                              icon: const Icon(Icons.cancel_outlined)),
                        ),
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: FileImage(File(cameraimage!.path)),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/PDF_file_icon 1.png'))),
                  ),
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 40),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Color(0xFF112C3B)),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xFF0B1C26),
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (value) => body = value,
                        textInputAction: TextInputAction.send,
                        controller: widget.contr,
                        decoration: InputDecoration(
                            hintText: LocaleKeys.typeMessage.tr(),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontSize: 17,
                                    color: const Color(0xFF848484)),
                            border: InputBorder.none),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          doc == null && cameraimage == null
                              ? InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 24),
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                xdoc =
                                                    await widget.cub.pickfile();
                                                setState(() {
                                                  doc = File(xdoc);
                                                  cameraimage = null;
                                                });
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    FontAwesomeIcons.solidFile,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3.2),
                                                  Text(
                                                    'File',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Divider(),
                                            InkWell(
                                              onTap: () async {
                                                xdoc = await widget.cub
                                                    .pickimageChat();

                                                setState(() {
                                                  cameraimage = xdoc;
                                                  doc = null;
                                                });
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    FontAwesomeIcons.image,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3.6),
                                                  Text(
                                                    'Gallery',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Divider(),
                                            InkWell(
                                              onTap: () async {
                                                xdoc = await widget.cub
                                                    .takeimage();
                                                setState(() {
                                                  cameraimage = xdoc;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                      Icons.camera_alt_sharp,
                                                      color: Colors.white),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3.6),
                                                  Text(
                                                    'Camera',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text(
                                                  "Cancel",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge!
                                                      .copyWith(
                                                          color: Colors
                                                              .blueAccent),
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.add_outlined,
                                    color: Color(0xFF5B7D90),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              BlocProvider(
                create: (context) => CommentsCubit(),
                child: BlocConsumer<CommentsCubit, CommentsState>(
                  listener: (context, state) {
                    if (state is PostLoadingstate) {
                      loading = true;
                    } else {
                      loading = false;
                    }
                  },
                  builder: (context, state) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(70),
                      onTap: () async {
                        /*for (var element in body!.split(' '))
                                                          {
                                                            element.contains('#') ? tags.add(element) : null,
                                                          },
                                                        print(tags),*/
                        HapticFeedback.heavyImpact();
                        await CommentsCubit.get(context).createNewPost(
                            image: cameraimage,
                            doc: doc,
                            body: body == null || body!.isEmpty ? '' : body,
                            id: widget.id,
                            tags: tags);
                        widget.contr.clear();
                        setState(() {
                          doc = null;
                          cameraimage = null;
                          body = null;
                          tags = [];
                          img = null;
                        });
                        widget.refresh();
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF8E704F),
                        radius: 20,
                        child: Center(
                          child: loading
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> saveImageToGallery(String imageUrl, BuildContext context) async {
  Dio dio = Dio();
  try {
    // Download the image
    Response<List<int>> response = await dio.get<List<int>>(imageUrl,
        options: Options(responseType: ResponseType.bytes));

    // Get the external storage directory
    final Directory? directory = await getExternalStorageDirectory();

    // Generate a unique filename
    String fileName = "${DateTime.now().toIso8601String()}.png";

    // Create the file path
    String filePath = '${directory!.path}/$fileName';

    // Write the image to the file
    File file = File(filePath);
    await file.writeAsBytes(response.data!);

    // Save the image to the gallery
    final result = await ImageGallerySaver.saveFile(filePath);

    print("Image saved to gallery: $result");
  } catch (e) {
    print("Error saving image: $e");
  }
}

void downloadFile({required String url}) async {
  var path = url.split('/').last;
  var dio = Dio();
  Directory directory = await getApplicationDocumentsDirectory();
  var response = await dio.download(url, "${directory.path}/$path");
  print(response.data);
}
