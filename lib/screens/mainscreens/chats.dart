import 'package:chatjob/Hive/localdata.dart';

import 'package:chatjob/cubits/settingsC/settings_cubit.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/method/GroupNet.dart';
import 'package:chatjob/models/allgroups_model.dart';
import 'package:chatjob/screens/AdminScreens/CreateAndEditGroup.dart';
import 'package:chatjob/screens/groupchat/chatscreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:chatjob/screens/notifications.dart';
import 'package:chatjob/widget/ImageWidget.dart';
import 'package:chatjob/widget/groupswid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Chatsscreen extends StatefulWidget {
  const Chatsscreen({super.key, required this.admin});
  final bool admin;

  @override
  State<Chatsscreen> createState() => _ChatsscreenState();
}

class _ChatsscreenState extends State<Chatsscreen> {
  TextEditingController searchcont = TextEditingController();
  @override
  void initState() {
    name = pref.getString('UserName');
    loginbox!.get('Admin') ? getAdminGroups() : getMyGroups();
    super.initState();
  }

  String? name;
  getAdminGroups() async {
    x = await getAdminallGroup();
    if (mounted) {
      setState(() {
        chats = x;
      });
    }
  }

  getMyGroups() async {
    x = await getMyAllGroups();
    if (mounted) {
      setState(() {
        chats = x;
      });
    }
  }

  List<AllGroupsModel>? x, chats;
  Color filtercolor = const Color.fromRGBO(47, 74, 110, 1);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: MediaQuery.paddingOf(context),
            child: Column(
              children: [
                ProfileRow(
                  name: name,
                  notiNum: pref.getInt('Notification')!,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 30 * 0.8, top: 22, bottom: 14),
                  child: Row(
                    children: [
                      SearchGroupChat(
                        searchcont: searchcont,
                        onchange: (p0) {
                          final String z = p0;

                          p0.isEmpty
                              ? widget.admin
                                  ? getAdminGroups()
                                  : getMyGroups()
                              : setState(() {
                                  chats = chats!
                                      .where((element) => element.name!
                                          .toLowerCase()
                                          .contains(z.toLowerCase()))
                                      .toList();
                                });
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16)),
                        child: IconButton(
                            onPressed: () {
                              filtercolor == Colors.blue
                                  ? setState(
                                      () {
                                        chats = x;
                                        filtercolor = const Color.fromRGBO(
                                            47, 74, 110, 1);
                                      },
                                    )
                                  : setState(() {
                                      chats = chats!
                                          .where((element) =>
                                              element.unreadPostsCount != 0)
                                          .toList();
                                      filtercolor = Colors.blue;
                                    });
                            },
                            icon: FaIcon(
                              Icons.filter_list,
                              color: filtercolor,
                            )),
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Color(0xFF253C5B),
                  thickness: 0.5,
                ),
                chats == null
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 5),
                        child: Center(
                            child: Lottie.asset('assets/images/JP LOADING.json',
                                height: MediaQuery.of(context).size.width / 1.5,
                                width:
                                    MediaQuery.of(context).size.width / 1.5)),
                      )
                    : chats!.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 4),
                            child: Center(
                              child: Text(
                                'No Groups yet',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                itemBuilder: (context, i) {
                                  return InkWell(
                                      onTap: () => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => InChatScreen(
                                                    admin: widget.admin,
                                                    id: chats![i].id!,
                                                    name: chats![i].name!,
                                                    imageurl: chats![i].image,
                                                    saveimages: chats![i]
                                                            .settings!
                                                            .saveToGallery ==
                                                        'always',
                                                  ))),
                                      child: Slidable(
                                          startActionPane: ActionPane(
                                              extentRatio: 0.3,
                                              motion: const StretchMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (cx) async {
                                                    await SettingsCubit.get(
                                                            context)
                                                        .pinchat(
                                                            pined: !chats![i]
                                                                .settings!
                                                                .isPinned!,
                                                            id: chats![i].id!);
                                                    widget.admin
                                                        ? getAdminGroups()
                                                        : getMyGroups();
                                                  },
                                                  backgroundColor:
                                                      const Color(0xFF2F4A6E),
                                                  icon:
                                                      chats![i]
                                                              .settings!
                                                              .isPinned!
                                                          ? FluentIcons
                                                              .pin_off_20_filled
                                                          : FluentIcons
                                                              .pin_20_filled,
                                                  label: chats![i]
                                                          .settings!
                                                          .isPinned!
                                                      ? LocaleKeys
                                                          .horiSlideunpin
                                                          .tr()
                                                      : LocaleKeys.horiSlidepin
                                                          .tr(),
                                                )
                                              ]),
                                          endActionPane: ActionPane(
                                              extentRatio: 0.3,
                                              motion: const StretchMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (cx) async {
                                                    await SettingsCubit.get(
                                                            context)
                                                        .unreadchat(
                                                            unread: true,
                                                            id: chats![i].id!);
                                                    widget.admin
                                                        ? getAdminGroups()
                                                        : getMyGroups();
                                                  },
                                                  backgroundColor:
                                                      const Color(0xFF0F53AF),
                                                  icon: Icons.mark_chat_unread,
                                                  label: LocaleKeys
                                                      .horiSlideUnread
                                                      .tr(),
                                                )
                                              ]),
                                          child: Chatrow(
                                            pinned: chats![i].settings == null
                                                ? false
                                                : chats![i].settings!.isPinned!,
                                            group: chats![i],
                                            number: widget.admin
                                                ? null
                                                : chats![i].unreadPostsCount!,
                                            admin: widget.admin,
                                            time: chats![i].updatedAt == null
                                                ? '0:0'
                                                : DateFormat.Hm().format(
                                                    DateTime.parse(
                                                        chats![i].updatedAt!)),
                                          )));
                                },
                                separatorBuilder: (context, index) =>
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 112, right: 30),
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Color(0xFF253C5B),
                                      ),
                                    ),
                                itemCount: chats!.length),
                          ),
              ],
            ),
          ),
          floatingActionButton: widget.admin
              ? Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20 * 0.8, right: 20 * 0.8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EditANDCreateGroup(
                                  create: true,
                                  title: 'Create Group',
                                  image: 'assets/images/download.jpg',
                                ))),
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(17, 44, 59, 1),
                            borderRadius: BorderRadius.circular(18)),
                        height: MediaQuery.of(context).size.width / 6.3,
                        width: MediaQuery.of(context).size.width / 6.3,
                        child:
                            SvgPicture.asset('assets/images/VectorJacob.svg')),
                  ),
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
        ),
      ),
    );
  }
}

class SearchGroupChat extends StatelessWidget {
  const SearchGroupChat({
    super.key,
    required this.searchcont,
    required this.onchange,
  });

  final TextEditingController searchcont;
  final Function(String)? onchange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFF0A2432),
            borderRadius: BorderRadius.circular(16)),
        height: 42,
        width: MediaQuery.of(context).size.width - 120,
        child: TextFormField(
          controller: searchcont,
          onChanged: onchange,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(5),
              prefixIcon: const Icon(
                Icons.search,
                size: 24,
                color: Color(0xFF2F4A6F),
              ),
              fillColor: const Color.fromARGB(255, 15, 57, 80),
              hintText: LocaleKeys.searchGroups.tr(),
              hintStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: const Color(0xFF2F4A6F), fontWeight: FontWeight.w400),
              border: InputBorder.none),
        ),
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    required this.name,
    required this.notiNum,
  });

  final String? name;
  final int notiNum;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                height: 42,
                width: 42,
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(142, 112, 79, 1),
                  radius: 12,
                ),
              ),
              const SizedBox(
                height: 40,
                width: 40,
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(2, 20, 31, 1),
                  radius: 12,
                ),
              ),
              pref.getString('Userimage') == null
                  ? const CircleAvatar(
                      //  backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/images/no profilepic.png'),
                      radius: 18,
                    )
                  : const ProfileImagewidget()
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            name!,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        const Spacer(),
        Container(
          alignment: Alignment.center,
          height: 24,
          width: 24,
          margin: const EdgeInsets.only(right: 30, top: 16),
          child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const NotificationsScreen())),
              child: Stack(
                children: [
                  const Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.notifications)),
                  notiNum == 0
                      ? const SizedBox()
                      : Align(
                          alignment: const Alignment(0.999, -0.9),
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 6,
                            child: Text(
                              notiNum.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 6, color: Colors.white),
                            ),
                          ),
                        )
                ],
              )),
        )
      ],
    );
  }
}
