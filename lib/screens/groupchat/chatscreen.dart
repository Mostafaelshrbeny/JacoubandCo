import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/comments/comments_cubit.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/method/GroupNet.dart';
import 'package:chatjob/models/group_model.dart';
import 'package:chatjob/screens/mainscreen.dart';

import 'package:chatjob/widget/chatwidgets.dart/message.dart';
import 'package:chatjob/widget/chatwidgets.dart/typemessage.dart';
import 'package:chatjob/method/groupposts.dart';
import 'package:chatjob/models/messages_model.dart';
import 'package:chatjob/screens/groupchat/groupinfo.dart';
import 'package:chatjob/widget/ImageWidget.dart';
import 'package:chatjob/widget/chatwidget.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class InChatScreen extends StatefulWidget {
  const InChatScreen(
      {super.key,
      required this.admin,
      required this.id,
      required this.name,
      required this.imageurl,
      required this.saveimages});
  final bool admin;
  final bool? saveimages;
  final int id;
  final String? name;
  final String? imageurl;

  @override
  State<InChatScreen> createState() => _InChatScreenState();
}

class _InChatScreenState extends State<InChatScreen> {
  ScrollController scControll = ScrollController();
  void scrollListener() {
    if (scControll.offset >= scControll.position.maxScrollExtent - 5 &&
        !scControll.position.outOfRange) {
      print("object");
      page <= pages! ? getPosts(null) : null;
    }
  }

  @override
  void initState() {
    getGroupInfo();
    getPosts(1);
    scControll.addListener(scrollListener);
    super.initState();
  }

  getGroupInfo() async {
    g = await getGroupmembers(id: widget.id);
    setState(() {
      groupinfo = g;
    });
  }

  GroupModel? g, groupinfo;
  getPosts(int? pagenum) async {
    z = await getGroupPosts(id: widget.id, page: pagenum ?? page);
    setState(() {
      pagenum == 1 ? chatPosts = z!.data : chatPosts = chatPosts! + z!.data!;
      pages = z!.totalCount;
      links = [];
      wallpaper = pref.getString('wallpaper');
    });
    pagenum == null || pagenum == 1 ? page++ : null;
    for (var element in z!.data!) {
      if (!element.isRead!) {
        readPost(postid: element.id!, groupid: element.groupId!);
        if (element.attachments!.isNotEmpty &&
            groupinfo!.settings!.saveToGallery == 'always') {
          element.attachments![0].type == 'media'
              ? context.mounted
                  ? saveImageToGallery(element.attachments![0].url!, context)
                  : null
              : null;
        }
      }
    }

    @override
    void dispose() {
      // Dispose of the controller to avoid memory leaks
      scControll.dispose();
      super.dispose();
    }
  }
  /* for (var element in z!.data!) {
      final urlRegExp = RegExp(
          r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
      final urlMatches = urlRegExp.allMatches(element.body!);
      links = urlMatches
          .map((urlMatch) =>
              element.body!.substring(urlMatch.start, urlMatch.end))
          .toList();

*/

  int page = 1;
  int? pages;
  MessagesModel? z;
  List<Data>? chatPosts = [];
  String? wallpaper;
  TextEditingController contr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          current = 1;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => const Mainscreen(
                      inApp: true,
                    )));
        return true;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CommentsCubit(),
          ),
        ],
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
                          onPressed: () {
                            setState(() {
                              current = 1;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Mainscreen(
                                          inApp: true,
                                        )));
                          },
                          icon: const Icon(Icons.arrow_back_ios_new))),
                  title: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => GroupInfoScreen(
                                    id: widget.id,
                                    admin: widget.admin,
                                  )));
                    },
                    child: Row(
                      children: [
                        InGroupChatImage(groupimage: groupinfo?.image),
                        Text(groupinfo == null ? '' : groupinfo!.name!,
                            style:
                                Theme.of(context).appBarTheme.titleTextStyle!)
                      ],
                    ),
                  ),
                ),
                body: chatPosts == null || wallpaper == null
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 7),
                        child: Center(
                            child: Lottie.asset('assets/images/JP LOADING.json',
                                height: MediaQuery.of(context).size.width / 1.5,
                                width:
                                    MediaQuery.of(context).size.width / 1.5)),
                      )
                    : CachedNetworkImage(
                        imageUrl: wallpaper!,
                        errorWidget: (context, url, error) => Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 5),
                          child: Center(
                              child: Lottie.asset(
                                  'assets/images/JP LOADING.json',
                                  height:
                                      MediaQuery.of(context).size.width / 1.5,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5)),
                        ),
                        placeholder: (context, url) => Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 5),
                          child: Center(
                              child: Lottie.asset(
                                  'assets/images/JP LOADING.json',
                                  height:
                                      MediaQuery.of(context).size.width / 1.5,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5)),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    controller: scControll,
                                    padding: const EdgeInsets.only(bottom: 8),
                                    //addAutomaticKeepAlives: true,
                                    // Add this property
                                    // cacheExtent: double.infinity,
                                    physics: const BouncingScrollPhysics(),
                                    reverse: true,

                                    dragStartBehavior: DragStartBehavior.down,
                                    itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          top: 5,
                                          left: 20,
                                          bottom: 8),
                                      child: Builder(builder: (context) {
                                        return InkWell(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(2),
                                              bottomRight: Radius.circular(20)),
                                          onLongPress: () => {
                                            HapticFeedback.heavyImpact(),
                                            showGeneralDialog(
                                              barrierColor: Colors.black
                                                  .withOpacity(0.91),
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 100),
                                              barrierLabel: 'null',
                                              barrierDismissible: true,
                                              context: context,
                                              pageBuilder: (context, a1, a2) =>
                                                  Container(),
                                              transitionBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) =>
                                                  ScaleTransition(
                                                scale: Tween<double>(
                                                        begin: 0.5, end: 1.0)
                                                    .animate(animation),
                                                child: Messagefocused(
                                                  content: chatPosts![index],
                                                  isAdmin: widget.admin,
                                                  refresh: () async {
                                                    page = 1;
                                                    await getPosts(1);
                                                    getPosts(null);
                                                  },
                                                ),
                                              ),
                                            )
                                          },
                                          child: Messagewidget(
                                            admin: widget.admin,
                                            content: chatPosts![index],
                                            gID: widget.id,
                                            pID: chatPosts![index].id!,
                                            save: widget.saveimages ??
                                                groupinfo!.settings!
                                                        .saveToGallery ==
                                                    'always',
                                            gName: widget.name,
                                            gImage: widget.imageurl,
                                          ),
                                        );
                                      }),
                                    ),
                                    itemCount: chatPosts!.length,
                                  ),
                                ),
                                widget.admin
                                    ? MessageInputWidget(
                                        contr: contr,
                                        cub: cub,
                                        refresh: () {
                                          getPosts(1);
                                        },
                                        id: widget.id,
                                      )
                                    : const SizedBox(),
                                widget.admin
                                    ? AddEmojiWidget(
                                        keyboardVisible: keyboardVisible,
                                        cub: cub,
                                        contr: contr)
                                    : const SizedBox()
                              ],
                            )),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AddEmojiWidget extends StatelessWidget {
  const AddEmojiWidget({
    super.key,
    required this.keyboardVisible,
    required this.cub,
    required this.contr,
  });

  final bool keyboardVisible;
  final CommentsCubit cub;
  final TextEditingController contr;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: keyboardVisible ? true : cub.emojivis,
      child: SizedBox(
          height: 250,
          child: EmojiPicker(
            onEmojiSelected: (category, emoji) =>
                contr.text = contr.text + emoji.emoji,
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
          )),
    );
  }
}
