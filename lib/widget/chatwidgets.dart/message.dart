import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatjob/models/messages_model.dart';
import 'package:chatjob/screens/groupchat/comments.dart';
import 'package:chatjob/screens/groupchat/pdfscreen.dart';
import 'package:chatjob/widget/ImageWidget.dart';
import 'package:chatjob/widget/chatwidget.dart';
import 'package:flutter/material.dart';

class Messagewidget extends StatefulWidget {
  const Messagewidget({
    super.key,
    required this.content,
    this.gID,
    this.pID,
    this.comments = true,
    required this.admin,
    required this.save,
    required this.gName,
    required this.gImage,
  });
  final bool? comments, admin, save;
  final Data content;
  final int? gID, pID;
  final String? gName, gImage;

  @override
  State<Messagewidget> createState() => _MessagewidgetState();
}

class _MessagewidgetState extends State<Messagewidget> {
  /* List<Widget> tagsRow = [];
  @override
  void initState() {
    showTags();
    super.initState();
  }

  String x = '';
  String c = '';
  showTags() {
    setState(() {
      c = widget.content.body!;
      c.split(' ').removeWhere((element) => element.contains('#'));
    });
    /*setState(() {
      widget.content.body!
          .split('')
          .removeWhere((element) => element.contains('#'));
    });*/
    for (var element in widget.content.tags!) {
      setState(() {
        x.split(' ').add(element.tag!);
      });
      print(x);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
            color: Color(0xFF0A2432),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(20))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          widget.content.attachments!.isEmpty
              ? const SizedBox(
                  height: 20 * 0.8,
                )
              : widget.content.attachments![0].type == 'media'
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 12 * 0.8),
                      child: ImageWid(
                          height: MediaQuery.of(context).size.height / 6,
                          width: double.infinity,
                          imageUrl: widget.content.attachments![0].url!,
                          noImage: 'assets/images/loadimage.png'),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 12 * 0.8),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PdfScreen(
                                    url: widget.content.attachments![0].url!))),
                        child: const Image(
                            image: AssetImage(
                                'assets/images/PDF_file_icon 1.png')),
                      ),
                    ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.content.body == null
                    ? const SizedBox()
                    : Text(
                        widget.content.body!,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                const SizedBox(height: 12 * 0.8),
                /* x.isEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          x,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  color: const Color.fromRGBO(0, 136, 212, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                        ),
                      ),*/
                widget.content.reactions!.isEmpty
                    ? const SizedBox()
                    : Row(
                        children: [
                          widget.content.reactions!.isNotEmpty
                              ? EmojiContainer(
                                  emoji: widget.content.reactions![0].reaction!,
                                  count: widget.content.reactions![0].count!,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            width: 5,
                          ),
                          widget.content.reactions!.length >= 2
                              ? EmojiContainer(
                                  emoji: widget.content.reactions![1].reaction!,
                                  count: widget.content.reactions![1].count!)
                              : const SizedBox(),
                          const SizedBox(width: 8),
                        ],
                      ),
                const SizedBox(height: 8),
                widget.comments!
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Divider(
                          thickness: 1,
                        ),
                      )
                    : const SizedBox(
                        width: double.infinity,
                      ),
                const SizedBox(height: 12 * 0.7),
                widget.comments!
                    ? InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CommentsScreen(
                                        admin: widget.admin!,
                                        groupid: widget.gID!,
                                        postid: widget.pID!,
                                        save: widget.save!,
                                        gName: widget.gName,
                                        gImage: widget.gImage,
                                      )));
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: 50,
                              margin: const EdgeInsets.only(right: 8),
                              child: Stack(
                                children: [
                                  widget.content.lastCommenters!.length >= 4
                                      ? Align(
                                          alignment: const Alignment(-3, 0),
                                          child: CommentersImage(
                                            image: widget.content
                                                .lastCommenters![3].image!,
                                          ),
                                        )
                                      : const SizedBox(),
                                  widget.content.lastCommenters!.length >= 2
                                      ? Align(
                                          alignment: const Alignment(-2, 0),
                                          child: CommentersImage(
                                            image: widget.content
                                                .lastCommenters![1].image!,
                                          ))
                                      : const SizedBox(),
                                  widget.content.lastCommenters!.isNotEmpty
                                      ? Align(
                                          alignment: const Alignment(-0.8, 0),
                                          child: CommentersImage(
                                            image: widget.content
                                                .lastCommenters![0].image!,
                                          ),
                                        )
                                      : const SizedBox(),
                                  widget.content.lastCommenters!.length >= 3
                                      ? Align(
                                          alignment: const Alignment(0.8, 0),
                                          child: CommentersImage(
                                            image: widget.content
                                                .lastCommenters![2].image!,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            Text(
                              '${widget.content.commentsCount} comments',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                      color: const Color(0xFFCFCECA),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 22 * 0.5)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class EmojiContainer extends StatelessWidget {
  const EmojiContainer({
    super.key,
    required this.emoji,
    required this.count,
  });
  final String emoji;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(237, 237, 237, 1).withOpacity(0.2)),
      child: Text(
        '$emoji $count',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: const Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

class CommentersImage extends StatelessWidget {
  const CommentersImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      placeholder: (context, url) => const CircleAvatar(
        backgroundImage: AssetImage('assets/images/no profilepic.png'),
        radius: 14,
      ),
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
        radius: 14,
      ),
      errorWidget: (context, url, error) => const CircleAvatar(
        backgroundImage: AssetImage('assets/images/no profilepic.png'),
        radius: 14,
      ),
    );
  }
}
