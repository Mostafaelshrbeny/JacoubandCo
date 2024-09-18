import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatjob/Hive/localdata.dart';

import 'package:chatjob/cubits/GroupInfo/group_info_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/GroupData/group_data_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/GroupData/group_data_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';

import 'package:chatjob/method/GroupNet.dart';

import 'package:chatjob/method/users.dart';
import 'package:chatjob/models/group_model.dart';
import 'package:chatjob/models/users_model.dart';
import 'package:chatjob/screens/AdminScreens/CreateAndEditGroup.dart';
import 'package:chatjob/screens/groupchat/Sharedmediascreens/sharedmedia.dart';

import 'package:chatjob/widget/GroupInfoWid.dart';
import 'package:chatjob/widget/GroupOptionWidgets.dart';
import 'package:chatjob/widget/member.dart';
import 'package:chatjob/widget/publicwid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class GroupInfoScreen extends StatefulWidget {
  const GroupInfoScreen({
    super.key,
    required this.admin,
    required this.id,
  });
  final bool admin;
  final int id;

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  @override
  void initState() {
    getGrouppRef();

    super.initState();
  }

  getGrouppRef() async {
    loginbox!.get('Admin') ? x = await getallUsers() : null;
    y = await getMyGroupData(id: widget.id);
    //edit the admin Group api path
    z = widget.admin
        ? await getGroupmembers(id: widget.id)
        : await getMyGroupData(id: widget.id);
    setState(() {
      allmembers = z;
    });
    setState(() {
      settings = y!.settings;
      users = x!.where((element) => element.active == true).toList();
    });
    print(y!.settings);
  }

  List<UsersModel>? x;
  List<UsersModel>? users;
  GroupModel? y;
  Settings? settings;
  GroupModel? allmembers, z;
  // dynamic y, settings, allmembers, z;
  bool checked = false;
  int? mutenum;
  String? muteop;
  int? savenum;
  String? saveop;
  @override
  Widget build(BuildContext context) {
    var searchcont = TextEditingController();
    var searchcont2 = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GroupDataCubit(),
        ),
        BlocProvider(
          create: (context) => GroupInfoCubit(),
        ),
      ],
      child: BlocConsumer<GroupDataCubit, GroupDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          var scub = GroupDataCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              actions: [
                widget.admin
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30 * 0.8, vertical: 20),
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EditANDCreateGroup(
                                        id: widget.id,
                                        title:
                                            LocaleKeys.groupInfoEditGroup.tr(),
                                        name: allmembers!.name,
                                        image: allmembers!.image,
                                        description: allmembers!.description,
                                        // allmembers['description'],
                                        create: false,
                                      ))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.groupInfoEditGroup.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        color: const Color(0xFFF9F9F9),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(width: 2),
                              const Padding(
                                padding: EdgeInsets.only(top: 3),
                                child: Icon(
                                  Icons.edit,
                                  size: 14,
                                  color: Color(0xFFF9F9F9),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
              elevation: 0,
              //  forceMaterialTransparency: true,
              backgroundColor: Colors.white.withOpacity(0),
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            ),
            body: settings == null && allmembers == null && settings == null
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 7),
                    child: Center(
                        child: Lottie.asset('assets/images/JP LOADING.json',
                            height: MediaQuery.of(context).size.width / 1.5,
                            width: MediaQuery.of(context).size.width / 1.5)),
                  )
                : ListView(
                    padding: const EdgeInsets.only(
                        right: 30 * 0.8, top: 73, left: 30 * 0.8, bottom: 20),
                    children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 12),
                          child: Container(
                            alignment: Alignment.center,
                            height: 96,
                            width: 96,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: allmembers!.image == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(22),
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/no imageGroup.png'),
                                      fit: BoxFit.cover,
                                      height: 96,
                                      width: 96,
                                    ),
                                  )
                                : CachedNetworkImage(
                                    key: UniqueKey(),
                                    imageUrl: allmembers!.image!,
                                    imageBuilder: (context, imageProvider) =>
                                        ClipRRect(
                                      borderRadius: BorderRadius.circular(22),
                                      child: Image(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        height: 96,
                                        width: 96,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        ClipRRect(
                                      borderRadius: BorderRadius.circular(22),
                                      child: const Image(
                                        height: 96,
                                        width: 96,
                                        image: AssetImage(
                                            'assets/images/no imageGroup.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    placeholder: (context, url) => Center(
                                        child: Lottie.asset(
                                            'assets/images/JP LOADING.json',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5)),
                                    placeholderFadeInDuration: Duration.zero,
                                  ),
                          ),
                        ),
                        Text(
                          allmembers!.name ?? '',
                          // allmembers['name'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${allmembers!.users!.length} ${LocaleKeys.groupInfoParticipants.tr()}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                  color: const Color(0xFFCFCECA)),
                        ),
                        SearchRow(
                            onchange: (p0) {},
                            searchcont: searchcont2,
                            label: LocaleKeys.groupInfoseachgroup.tr()),
                        Container(
                          padding: const EdgeInsets.all(22),
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 22),
                          decoration: BoxDecoration(
                              color: const Color(0xFF0A2432),
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            allmembers!.description ?? 'No bio',
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xFFAECEF8)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(top: 22),
                          decoration: BoxDecoration(
                              color: const Color(0xFF0A2432),
                              borderRadius: BorderRadius.circular(16)),
                          child: AdditionalRow(
                              x: 0,
                              label: LocaleKeys.groupInfoMediaLinksandDocs.tr(),
                              icon: const FaIcon(FontAwesomeIcons.film,
                                  color: Color(0xFFAECEF8)),
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SharedMediaScreen(
                                              id: widget.id,
                                            )));
                              }),
                        ),
                        OptionsWidget(
                          muteop: muteOption(),
                          mutenum: muteMethod(),
                          scub: scub,
                          widget: widget,
                          savenum: galleryMethod(),
                          saveop: settings!.saveToGallery ?? '',
                          id: widget.id,
                          settings: settings,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          '${allmembers!.users!.length} ${LocaleKeys.groupInfoParticipants.tr()}',
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFF9F9F9)),
                        ),
                        widget.admin
                            ? AddMembers(
                                cx: context,
                                wid: widget,
                                searchcont: searchcont,
                                checked: checked,
                                users: users!,
                                members: allmembers!.users,
                                // members: allmembers['users'],
                                // members: allmembers['users'],
                                id: widget.id,
                              )
                            : const SizedBox(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          margin: const EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                              color: const Color(0xFF0A2432),
                              borderRadius: BorderRadius.circular(16)),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return MembersRow(
                                  admin: widget.admin,
                                  id: loginbox!.get('id'),
                                  userid: allmembers!.users![index].id!,
                                  label: allmembers!.users![index].name ??
                                      'no name',
                                  memberimage:
                                      allmembers!.users![index].image ??
                                          'assets/images/no profilepic.png',
                                  ontap: () {
                                    memberbottomsheet(
                                        context,
                                        allmembers!.users![index],
                                        widget.id,
                                        widget);
                                  });
                            },
                            itemCount: allmembers!.users!.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Padding(
                              padding: EdgeInsets.only(right: 12, left: 32),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(top: 32),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color.fromRGBO(10, 36, 50, 1)),
                          child: Builder(builder: (cx) {
                            return InkWell(
                              onTap: () {
                                widget.admin
                                    ? showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(70)),
                                        context: cx,
                                        builder: (context) => GroupDelete(
                                            cx: cx,
                                            groupname: allmembers!.name!,
                                            id: widget.id),
                                      )
                                    : GroupDataCubit.get(context).exitGroup(
                                        id: widget.id, context: context);
                              },
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: Icon(
                                      Icons.cancel,
                                      color: Color(0xFFF80909),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    child: Text(
                                      widget.admin
                                          ? 'Delete Group'
                                          : LocaleKeys.groupInfoexit.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFFF80909)),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            );
                          }),
                        ),
                      ]),
          );
        },
      ),
    );
  }

  String muteOption() {
    return settings!.mute == 'unmute'
        ? LocaleKeys.groupInfomuteNomute.tr()
        : settings!.mute == 'one_week'
            ? LocaleKeys.groupInfomuteoneweek.tr()
            : LocaleKeys.groupInfomutetwoweek.tr();
  }

  int muteMethod() {
    return settings!.mute == 'unmute'
        ? 1
        : settings!.mute == 'one_week'
            ? 2
            : 3;
  }

  int galleryMethod() {
    return settings!.saveToGallery == 'default'
        ? 1
        : settings!.saveToGallery == 'always'
            ? 2
            : 3;
  }

  Future<PersistentBottomSheetController> memberbottomsheet(
      BuildContext context, dynamic userinfo, int id, Widget wid) async {
    return showBottomSheet(
      backgroundColor: const Color.fromARGB(255, 3, 27, 43),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return Memberpress(
          cx: context,
          userinfo: userinfo,
          groupId: id,
          wid: wid,
          admin: widget.admin,
        );
      },
    );
  }
}

class GroupDelete extends StatelessWidget {
  const GroupDelete({
    super.key,
    required this.cx,
    required this.groupname,
    required this.id,
  });
  final BuildContext cx;
  final String groupname;
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupDataCubit(),
      child: BlocConsumer<GroupDataCubit, GroupDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.5,
            decoration: BoxDecoration(
                color: const Color(0xFF02141F),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                          alignment: Alignment.topLeft,
                          onPressed: () {
                            Navigator.pop(cx);
                          },
                          icon: const Icon(Icons.close)),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(50),
                  margin: const EdgeInsets.all(15),
                  height: 120,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/done.png'))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Are you sure you want to delete",
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFF9F9F9)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        groupname,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFF9F9F9)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    children: [
                      Expanded(
                        child: Builder(builder: (cz) {
                          return InkWell(
                            onTap: () {
                              Navigator.pop(cx);
                            },
                            child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF8E704F)),
                                    color: const Color(0xFF02141F),
                                    borderRadius: BorderRadius.circular(70)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: Text(
                                    'NO',
                                    softWrap: false,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                            color: const Color(0xFF8E704F),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                  ),
                                )),
                          );
                        }),
                      ),
                      const SizedBox(width: 22),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            GroupDataCubit.get(context)
                                .deleteGroup(id: id, context: cx);
                          },
                          child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(142, 112, 79, 1),
                                  borderRadius: BorderRadius.circular(70)),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  'YES',
                                  softWrap: false,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                          color: const Color(0xFFF9F9F9),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
