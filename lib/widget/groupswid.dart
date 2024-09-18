import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatjob/models/allgroups_model.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chatrow extends StatelessWidget {
  const Chatrow({
    super.key,
    this.number,
    required this.pinned,
    required this.group,
    required this.admin,
    required this.time,
  });
  final String time;
  final int? number;
  final bool pinned, admin;
  final AllGroupsModel group;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.symmetric(vertical: 0),
      height: 80,
      child: Row(
        children: [
          GroupImage(group: group),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    group.name!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFF9F9F9)),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  group.description ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: const Color(0xFF848484), fontSize: 15.5),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    group.updatedAt == null
                        ? time
                        : int.parse(DateFormat('d').format(
                                        DateTime.parse(group.updatedAt!))) +
                                    1 <=
                                DateTime.now().day
                            ? int.parse(DateFormat('d').format(
                                            DateTime.parse(group.updatedAt!))) +
                                        1 ==
                                    DateTime.now().day
                                ? 'Yesterday'
                                : DateFormat.yMd()
                                    .format(DateTime.parse(group.updatedAt!))
                            : time,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: group.unreadPostsCount == 0
                            ? const Color(0xFF848484)
                            : const Color(0xFF0F53AF)),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pinned
                        ? const Icon(
                            FluentIcons.pin_12_filled,
                            color: Colors.grey,
                            size: 17,
                          )
                        : const SizedBox(),
                    group.unreadPostsCount == 0 ||
                            group.unreadPostsCount == null
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: const Color(0xFF0F53AF),
                              child: Text(
                                number.toString(),
                                style: const TextStyle(
                                    color: Color(0xFFF9F9F9), fontSize: 8),
                              ),
                            ),
                          ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GroupImage extends StatelessWidget {
  const GroupImage({
    super.key,
    required this.group,
  });

  final AllGroupsModel group;

  @override
  Widget build(BuildContext context) {
    return group.image == null
        ? Container(
            margin: const EdgeInsets.only(right: 17),
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: const Image(
                image: AssetImage('assets/images/no imageGroup.png'),
                fit: BoxFit.cover,
                height: 68.8,
                width: 68.8,
              ),
            ),
          )
        : CachedNetworkImage(
            key: UniqueKey(),
            imageUrl: group.image!,
            imageBuilder: (context, imageProvider) => Container(
              margin: const EdgeInsets.only(right: 17),
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  height: 68.8,
                  width: 68.8,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              margin: const EdgeInsets.only(right: 17),
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: const Image(
                  height: 68.8,
                  width: 68.8,
                  image: AssetImage('assets/images/no imageGroup.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            fadeInDuration: const Duration(milliseconds: 50),
            placeholder: (context, url) => Container(
              margin: const EdgeInsets.only(right: 17),
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: const Image(
                  height: 68.8,
                  width: 68.8,
                  image: AssetImage('assets/images/no imageGroup.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholderFadeInDuration: Duration.zero,
          );
  }
}
