import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/notificationmethod.dart';
import 'package:chatjob/models/notification_model.dart';
import 'package:chatjob/screens/groupchat/chatscreen.dart';
import 'package:chatjob/screens/groupchat/comments.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    getNotlist();
    super.initState();
  }

  getNotlist() async {
    x = await getNotification();
    setState(() {
      notificationsList = x;
    });
    readnoti(x: x!);
  }

  readnoti({required List<NotificationModel> x}) async {
    for (var element in x) {
      ids.add(element.id!);
    }
    ids.isEmpty ? null : await readNotifications(ids: ids);
  }

  List<NotificationModel>? x, notificationsList;
  List<int> ids = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: SizedBox(
              height: 10,
            )),
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(LocaleKeys.notification.tr()),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Icon(Icons.arrow_back_ios_new_rounded),
            )),
      ),
      body: notificationsList == null
          ? Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
              child: Center(
                  child: Lottie.asset('assets/images/JP LOADING.json',
                      height: MediaQuery.of(context).size.width / 1.5,
                      width: MediaQuery.of(context).size.width / 1.5)),
            )
          : notificationsList!.isEmpty
              ? Center(
                  child: Text(
                    'No Notifications yet....',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                )
              : ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  itemBuilder: (context, index) {
                    return NotificationWidget(
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      notificationsList![index].recordType ==
                                              'group'
                                          ? InChatScreen(
                                              admin: loginbox!.get('Admin'),
                                              id: notificationsList![index]
                                                  .recordId!,
                                              name: null,
                                              imageurl: null,
                                              saveimages: null)
                                          : CommentsScreen(
                                              groupid: notificationsList![index]
                                                  .parentRecordId!,
                                              postid: notificationsList![index]
                                                  .recordId!,
                                              admin: loginbox!.get('Admin'),
                                              save: null,
                                              gName: null,
                                              gImage: null)));
                        },
                        label: notificationsList![index].title!,
                        // picture: 'assets/images/Social Icon 1.png',
                        time: int.parse(DateFormat('d').format(DateTime.parse(notificationsList![index].createdAt!))) + 1 <=
                                DateTime.now().day
                            ? int.parse(DateFormat('d').format(DateTime.parse(
                                            notificationsList![index]
                                                .createdAt!))) +
                                        1 ==
                                    DateTime.now().day
                                ? 'Yesterday'
                                : DateFormat.yMd().format(DateTime.parse(
                                    notificationsList![index].createdAt!))
                            : DateFormat.Hm().format(DateTime.parse(
                                notificationsList![index].createdAt!)),
                        content: notificationsList![index].body!);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                  itemCount: notificationsList!.length),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    this.picture = 'assets/images/Notification.png',
    required this.label,
    required this.time,
    required this.content,
    required this.ontap,
  });
  final String picture, label, time, content;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color(0xFF0A2432),
          borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        //borderRadius: BorderRadius.circular(16),
        onTap: ontap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    height: 18,
                    width: 18,
                    margin: const EdgeInsets.only(right: 16),
                    child: Image(image: AssetImage(picture))),
                Text(
                  label,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFF9F9F9)),
                ),
                const Spacer(),
                Text(
                  time,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFFCFCECA),
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36, right: 12, top: 5),
              child: Text(
                content,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFFF9F9F9)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
