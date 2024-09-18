import 'dart:convert';
import 'dart:io';

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/NetworkCubits/cubit/group_posts_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/cubit/group_posts_state.dart';
import 'package:chatjob/cubits/comments/comments_cubit.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/groupposts.dart';
import 'package:chatjob/models/commentmodel.dart';
import 'package:chatjob/screens/groupchat/chatscreen.dart';
import 'package:chatjob/screens/mainscreens/chats.dart';

import 'package:chatjob/widget/chatwidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:easy_localization/easy_localization.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen(
      {super.key,
      required this.groupid,
      required this.postid,
      required this.admin,
      required this.save,
      required this.gName,
      required this.gImage});
  final int groupid, postid;
  final bool? admin, save;
  final String? gName, gImage;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  IO.Socket socket = IO.io(
      ${Constant.url},
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableReconnection()
          .setExtraHeaders(
              {"authorization": 'Bearer ${loginbox!.get('token')}'})
          .build());
  ScrollController scControll = ScrollController();
  void scrollListener() async {
    if (scControll.offset >= scControll.position.maxScrollExtent &&
        !scControll.position.outOfRange) {
      print('object');
      // print(comments.length);
      getcomments(comments[comments.length - 1].id! - 10);
    }
  }

  createcmt({required String? msg}) {
    imageToUpload == null
        ? socket.emit('create-group-post-comment', {
            "group_id": widget.groupid,
            "post_id": widget.postid,
            "comment": msg,
          })
        : socket.emit('create-group-post-comment', {
            "group_id": widget.groupid,
            "post_id": widget.postid,
            "comment": msg == null || msg.isEmpty ? '' : msg,
            "attachments": [imageToUpload]
          });
  }

  connectIo() {
    socket.connect();
    socket.onConnect((data) => print('connect'));
    socket.onConnecting((p) => print(['CONNECTING', p]));
    socket.onConnectError((data) => print(data));

    socket.emit('get-group-post-comments', {
      "group_id": widget.groupid,
      "post_id": widget.postid,
    });
    socket.on('get-group-post-comments', (data) {
      loading = false;
      comments.insert(0, CommentsModel.fromJson(data[0]));
      if (mounted) {
        setState(() {});
      }

      print(data);
    });
    socket.on('exception', (data) => print(data));
  }

  bool loading = false;
  TextEditingController contr = TextEditingController();
  @override
  void initState() {
    connectIo();
    getcomments(null);
    scControll.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controller to avoid memory leaks
    scControll.dispose();
    //connectIo();
    super.dispose();
  }

  getcomments(int? page) async {
    x = await getPostComments(
        groupid: widget.groupid, postid: widget.postid, page: page);

    if (x.isNotEmpty) {
      if (mounted) {
        setState(() {
          comments = comments + x;
        });
      }
    } else {
      print('empty============');
    }
    Future.delayed(const Duration(seconds: 5)).then((value) => setState(() {
          empt = true;
        }));
  }

  bool empt = false;
  List<CommentsModel> comments = [];
  List<CommentsModel> x = [];
  List? z;
  XFile? cameraimage, xdoc;
  @override
  Widget build(BuildContext context) {
    // bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => InChatScreen(
                      admin: widget.admin!,
                      id: widget.groupid,
                      name: widget.gName!,
                      imageurl: widget.gImage,
                      saveimages: widget.save,
                    )));
        return true;
      },
      child: BlocProvider(
        create: (context) => CommentsCubit(),
        child: BlocConsumer<CommentsCubit, CommentsState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cub = CommentsCubit.get(context);

            return GestureDetector(
              onTap: () {
                cub.closekey(context);
                cub.emojivis = true;
              },
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color(0xFF0A2432),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: IconButton(
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => InChatScreen(
                                      admin: widget.admin!,
                                      id: widget.groupid,
                                      name: widget.gName!,
                                      imageurl: widget.gImage,
                                      saveimages: widget.save,
                                    ))),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  ),
                  title: Text(
                    LocaleKeys.comments.tr(),
                  ),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    comments.isEmpty && empt == false
                        ? const LoadingCommentWidget()
                        : empt == true && comments.isEmpty
                            ? const Expanded(child: SizedBox())
                            : Expanded(
                                child: ListView.builder(
                                    controller: scControll,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    reverse: true,
                                    itemBuilder: (context, index) =>
                                        Commentwidget(
                                          emoji: '😉 10k',
                                          contetnt: comments[index],
                                        ),
                                    itemCount: comments.length),
                              ),
                    comments.isEmpty
                        ? const Expanded(child: SizedBox())
                        : const SizedBox(),
                    Column(
                      children: [
                        img == null
                            ? const SizedBox()
                            : Container(
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color: Color(0xFF112C3B)),
                                child: loading
                                    ? const LoadingCommentWidget()
                                    : Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    cameraimage == null;
                                                    base64Image = null;
                                                    img = null;
                                                    imageToUpload = null;
                                                  });
                                                },
                                                icon: const Icon(
                                                    Icons.cancel_outlined)),
                                          ),
                                          const ImageUploadedShow(),
                                        ],
                                      ),
                              ),
                        Container(
                          //height: 120,
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              top: 20, right: 20, left: 20, bottom: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF112C3B)),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.35,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF0B1C26),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF0B1C26),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    children: [
                                      CommentsTextField(contr: contr),
                                      Builder(builder: (cx) {
                                        return img == null
                                            ? InkWell(
                                                onTap: () {
                                                  commentsMediaBottom(
                                                      cx, context);
                                                },
                                                child: const Icon(
                                                  Icons.add_outlined,
                                                  color: Color(0xFF5B7D90),
                                                ),
                                              )
                                            : const SizedBox();
                                      })
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(70),
                                onTap: loading
                                    ? null
                                    : () async {
                                        HapticFeedback.heavyImpact();
                                        setState(() {
                                          loading = true;
                                        });
                                        contr.text.isEmpty &&
                                                imageToUpload == null
                                            ? null
                                            : await createcmt(msg: contr.text);

                                        contr.clear();

                                        img = null;
                                        base64Image = null;
                                        imageToUpload = null;

                                        //getcomments();
                                        //setState(() {});
                                      },
                                child: CircleAvatar(
                                  backgroundColor: const Color(0xFF8E704F),
                                  radius: 20,
                                  child: Center(
                                    child: loading
                                        ? const SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 1.5,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> commentsMediaBottom(BuildContext cx, BuildContext context) {
    return showModalBottomSheet(
      context: cx,
      builder: (cx) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                await CommentsCubit.get(context)
                    .uploadimage(source: ImageSource.gallery);

                setState(() {
                  cameraimage = img;
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
                  SizedBox(width: MediaQuery.of(context).size.width / 3.6),
                  Text(
                    'Gallery',
                    style: Theme.of(context).textTheme.displayLarge,
                  )
                ],
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () async {
                //xdoc =
                await CommentsCubit.get(context)
                    .uploadimage(source: ImageSource.camera);
                setState(() {
                  cameraimage = img;
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.camera_alt_sharp, color: Colors.white),
                  SizedBox(width: MediaQuery.of(context).size.width / 3.6),
                  Text(
                    'Camera',
                    style: Theme.of(context).textTheme.displayLarge,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () => {Navigator.pop(context), imageToUpload = null},
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Colors.blueAccent),
                ))
          ],
        ),
      ),
    );
  }
}

class CommentsTextField extends StatelessWidget {
  const CommentsTextField({
    super.key,
    required this.contr,
  });

  final TextEditingController contr;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        onSubmitted: (value) async {},
        textInputAction: TextInputAction.send,
        minLines: 1,
        maxLines: 5,
        controller: contr,
        decoration: InputDecoration(
            hintText: LocaleKeys.typeMessage.tr(),
            hintStyle: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 17, color: const Color(0xFF848484)),
            border: InputBorder.none),
      ),
    );
  }
}

class ImageUploadedShow extends StatelessWidget {
  const ImageUploadedShow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: FileImage(File(img!.path)), fit: BoxFit.cover)),
    );
  }
}

class LoadingCommentWidget extends StatelessWidget {
  const LoadingCommentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
      child: Center(
          child: Lottie.asset('assets/images/JP LOADING.json',
              height: MediaQuery.of(context).size.width / 1.5,
              width: MediaQuery.of(context).size.width / 1.5)),
    );
  }
}

/*  Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    /*  InkWell(
                                      onTap: () async {
                                        cub.pickfile();
                                      },
                                      child: const Icon(
                                        Icons.add_outlined,
                                        color: Color(0xFF5B7D90),
                                      ),
                                    ),*/
                                    const SizedBox(width: 5),
                                    // InkWell(
                                    //     onTap: () {
                                    //       cub.closekey(context);
                                    //       cub.emojifun();
                                    //     },
                                    //     child: const Icon(Icons.emoji_emotions,
                                    //         color: Color(0xFF5B7D90))),
                                    const SizedBox(width: 5),
                                    /*InkWell(
                                        onTap: () async {
                                          cub.takeimage();
                                        },
                                        child: const Icon(
                                            Icons.camera_alt_sharp,
                                            color: Color(0xFF5B7D90))),*/
                                  ],
                                ),*/
class EmojiWidget extends StatelessWidget {
  const EmojiWidget(
      {super.key,
      required this.keyboardVisible,
      required this.cub,
      required this.contr,
      this.react = false,
      this.gid,
      this.pid,
      this.refresh,
      this.cx});
  final bool react;
  final Function()? refresh;
  final bool keyboardVisible;
  final bool cub;
  final TextEditingController contr;
  final int? gid, pid;
  final BuildContext? cx;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: keyboardVisible ? true : cub,
      child: SizedBox(
          height: 250,
          child: BlocProvider(
            create: (context) => GroupPostsCubit(),
            child: BlocBuilder<GroupPostsCubit, GroupPostsState>(
              builder: (context, state) {
                return EmojiPicker(
                  onEmojiSelected: (category, emoji) => react
                      ? {
                          GroupPostsCubit.get(context).postReactions(
                              react: emoji.emoji, groupid: gid!, postid: pid!),
                          Navigator.pop(context),
                          Navigator.pop(cx!),
                          refresh!()
                        }
                      : contr.text = contr.text + emoji.emoji,
                  config: const Config(
                    columns: 9,
                    emojiSizeMax: 32,
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    gridPadding: EdgeInsets.zero,
                    initCategory: Category.RECENT,
                    bgColor: Color(0xFF0B1C26),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    backspaceColor: Colors.blue,
                    skinToneDialogBgColor: Colors.white,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    recentTabBehavior: RecentTabBehavior.RECENT,
                    recentsLimit: 28,
                    replaceEmojiOnLimitExceed: false,
                    noRecents: Text(
                      'No Recents',
                      style: TextStyle(fontSize: 20, color: Colors.black26),
                      textAlign: TextAlign.center,
                    ),
                    loadingIndicator: SizedBox.shrink(),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL,
                    checkPlatformCompatibility: true,
                  ),
                );
              },
            ),
          )),
    );
  }
}
