import 'dart:async';

import 'package:chatjob/cubits/NetworkCubits/cubit/group_posts_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/cubit/group_posts_state.dart';
import 'package:chatjob/method/groupposts.dart';
import 'package:chatjob/models/commentmodel.dart';
import 'package:chatjob/models/messages_model.dart';
import 'package:chatjob/screens/groupchat/comments.dart';
import 'package:chatjob/widget/ImageWidget.dart';
import 'package:chatjob/widget/chatwidgets.dart/message.dart';
import 'package:chatjob/widget/chatwidgets.dart/typemessage.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Messagefocused extends StatefulWidget {
  const Messagefocused({
    super.key,
    required this.content,
    this.isAdmin,
    required this.refresh,
  });

  final Data content;
  final bool? isAdmin;
  final Function() refresh;

  @override
  State<Messagefocused> createState() => _MessagefocusedState();
}

class _MessagefocusedState extends State<Messagefocused> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => Timer.periodic(
            const Duration(milliseconds: 60),
            (_) => setState(() {
                  op < 0.9 ? op += 0.1 : null;
                })));

    super.initState();
  }

  double op = 0;
  @override
  Widget build(BuildContext context) {
    TextEditingController cont = TextEditingController();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      contentPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.only(left: 30),
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(7)),
        child: Stack(children: [
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => Navigator.pop(context),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Opacity(
                opacity: op,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    curve: Curves.easeInOutBack,
                    duration: const Duration(milliseconds: 1000),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A2432),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: BlocProvider(
                      create: (context) => GroupPostsCubit(),
                      child: BlocConsumer<GroupPostsCubit, GroupPostsState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await GroupPostsCubit.get(context)
                                      .postReactions(
                                          react: '👍',
                                          groupid: widget.content.groupId!,
                                          postid: widget.content.id!);
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                  widget.refresh();
                                },
                                child: const Text(
                                  '👍',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              const SizedBox(
                                width: 13,
                              ),
                              InkWell(
                                onTap: () async {
                                  await GroupPostsCubit.get(context)
                                      .postReactions(
                                          react: '😳',
                                          groupid: widget.content.groupId!,
                                          postid: widget.content.id!);
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                  widget.refresh();
                                },
                                child: const Text(
                                  '😳',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              const SizedBox(
                                width: 13,
                              ),
                              InkWell(
                                onTap: () async {
                                  await GroupPostsCubit.get(context)
                                      .postReactions(
                                          react: '🙄',
                                          groupid: widget.content.groupId!,
                                          postid: widget.content.id!);
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                  widget.refresh();
                                },
                                child: const Text(
                                  '🙄',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              const SizedBox(
                                width: 13,
                              ),
                              InkWell(
                                onTap: () async {
                                  await GroupPostsCubit.get(context)
                                      .postReactions(
                                          react: '❤️',
                                          groupid: widget.content.groupId!,
                                          postid: widget.content.id!);
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                  widget.refresh();
                                },
                                child: const Text(
                                  '❤️',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              const SizedBox(
                                width: 13,
                              ),
                              Builder(builder: (cx) {
                                return InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: cx,
                                        builder: (context) => EmojiWidget(
                                            pid: widget.content.id,
                                            refresh: widget.refresh,
                                            gid: widget.content.groupId,
                                            react: true,
                                            keyboardVisible: false,
                                            cx: context,
                                            cub: false,
                                            contr: cont),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.add_circle_rounded,
                                      color: Color(0xFF2F4A6E),
                                      size: 30,
                                    ));
                              })
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Messagewidget(
                content: widget.content,
                comments: false,
                admin: null,
                save: null,
                gName: '',
                gImage: '',
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsetsDirectional.only(
                    end: MediaQuery.of(context).size.width / 3),
                decoration: const BoxDecoration(
                    color: Color(0xFF0A2432),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.content.body!));
                        Navigator.pop(context);
                      },
                      child: const Row(
                        children: [
                          Text('Copy'),
                          Spacer(),
                          FaIcon(
                            FontAwesomeIcons.solidCopy,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    widget.content.attachments!.isEmpty
                        ? const SizedBox()
                        : const Divider(),
                    widget.content.attachments!.isEmpty
                        ? const SizedBox()
                        : InkWell(
                            onTap: () async {
                              widget.content.attachments![0].type == 'media'
                                  ? await saveImageToGallery(
                                      widget.content.attachments![0].url!,
                                      context)
                                  : downloadFile(
                                      url: widget.content.attachments![0].url!);
                              if (context.mounted) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'Saved',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                ));
                              }
                            },
                            child: const Row(
                              children: [
                                Text('Save'),
                                Spacer(),
                                FaIcon(
                                  FontAwesomeIcons.download,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                    widget.isAdmin == null || !widget.isAdmin!
                        ? const SizedBox()
                        : const Divider(),
                    widget.isAdmin == null
                        ? const SizedBox()
                        : widget.isAdmin!
                            ? InkWell(
                                onTap: () async {
                                  await deletePost(
                                      postid: widget.content.id!,
                                      groupid: widget.content.groupId!);
                                  widget.refresh();
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'Deleted',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                      backgroundColor:
                                          Colors.black.withOpacity(0.8),
                                      duration:
                                          const Duration(milliseconds: 500),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                    ));
                                  }
                                },
                                child: const Row(
                                  children: [
                                    Text('Delete'),
                                    Spacer(),
                                    Icon(
                                      FluentIcons.delete_20_filled,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                  ],
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}

class Commentwidget extends StatelessWidget {
  const Commentwidget({
    super.key,
    required this.emoji,
    required this.contetnt,
  });
  final String emoji;
  final CommentsModel contetnt;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width / 4,
          top: 5,
          left: 30,
          bottom: 17),
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
          color: Color(0xFF0A2432),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            ImageWid(
              imageUrl: contetnt.user!.image!,
              noImage: 'assets/images/no profilepic.png',
              raduis: 10,
              margin: const EdgeInsets.only(
                  top: 8 * 0.8, bottom: 10 * 0.8, left: 18, right: 8),
              height: 29,
              width: 29,
            ),
            Text(
              contetnt.user!.name!,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFF9F9F9)),
            ),
            const Spacer()
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22 * 0.8),
          child: Divider(),
        ),
        const SizedBox(height: 10 * 0.8),
        contetnt.attachments!.isEmpty
            ? const SizedBox()
            : ImageWid(
                imageUrl: contetnt.attachments![0].url!,
                noImage: 'assets/images/loadimage.png',
                height: 150,
                width: double.infinity,
              ),
        const SizedBox(height: 10 * 0.8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contetnt.comment!,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 22 * 0.8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  DateFormat.Hm().format(DateTime.parse(contetnt.createdAt!)),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: const Color(0xFFCFCECA),
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ]),
    );
  }
}
