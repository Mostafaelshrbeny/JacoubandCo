import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/GroupNet.dart';
import 'package:chatjob/method/users.dart';
import 'package:chatjob/models/users_model.dart';

import 'package:chatjob/screens/editprofile.dart';
import 'package:chatjob/widget/ImageWidget.dart';
import 'package:chatjob/widget/infowidgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MemberInfoScreen extends StatefulWidget {
  const MemberInfoScreen(
      {super.key, required this.id, required this.gId, required this.admin});
  final int id, gId;
  final bool admin;

  @override
  State<MemberInfoScreen> createState() => _MemberInfoScreenState();
}

class _MemberInfoScreenState extends State<MemberInfoScreen> {
  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    x = await getUserinfo(id: widget.id);
    y = await getAdminallGroup();
    setState(() {
      userInfo = x;
      // userGroups = y.entries.where((element) => element['users']);
    });
  }

  UsersModel? x, userInfo, userGroups;
  late List<dynamic> y;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30 * 0.8, vertical: 20),
            child: InkWell(
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Editprofilscreen(
                            gid: widget.gId,
                            admin: widget.admin,
                            id: userInfo!.id,
                            user: true,
                            image: userInfo!.image,
                            bio: userInfo!.bio ?? 'No Bio',
                            name: userInfo!.name ?? '',
                            email: userInfo!.email ?? '',
                            location: userInfo!.country ?? 'No Location',
                            phone: userInfo!.phone ?? 'No Phone Number',
                          ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.editUser.tr(),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
          ),
        ],
      ),
      body: userInfo == null
          ? Center(
              child: Text(
                'Loading User Info...',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            )
          : ListView(children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 12),
                child: userInfo!.image == null
                    ? Container(
                        alignment: Alignment.center,
                        height: 96,
                        width: 96,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: const Image(
                                image: AssetImage(
                                    'assets/images/no profilepic.png'),
                                fit: BoxFit.cover)))
                    : ImageWid(
                        imageUrl: userInfo!.image!,
                        noImage: 'assets/images/no profilepic.png',
                        height: 96,
                        width: 96,
                      ),
              ),
              Text(
                userInfo!.name!,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 32),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30 * 0.8),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromRGBO(10, 36, 50, 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoRaw(
                        dataname: LocaleKeys.email.tr(),
                        data: userInfo!.email!),
                    const Divider(),
                    InfoRaw(
                      dataname: LocaleKeys.phone.tr(),
                      data: userInfo!.phone ?? 'No phone number',
                    ),
                    /*  const Divider(),
                    InfoRaw(
                        dataname: LocaleKeys.location.tr(),
                        data: userInfo!.country ?? 'No Location yet')*/
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(22),
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                    vertical: 22, horizontal: 30 * 0.8),
                decoration: BoxDecoration(
                    color: const Color(0xFF0A2432),
                    borderRadius: BorderRadius.circular(16)),
                child: Text(
                  userInfo!.bio ?? 'No Bio',
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFFAECEF8)),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  LocaleKeys.groups.tr(),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFCFCECA)),
                ),
              ),
              ListView.separated(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 30 * 0.8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: userInfo!.groups![index]['image'] == null
                          ? Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/no imageGroup.png'))),
                            )
                          : ImageWid(
                              imageUrl: userInfo!.groups![index]['image'],
                              noImage: 'assets/images/no imageGroup.png',
                              height: 50,
                              width: 50,
                              raduis: 8,
                            ),
                    ),
                    Text(
                      userInfo!.groups![index]['name'],
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Divider(),
                ),
                itemCount: userInfo!.groups!.length,
              )
            ]),
    );
  }
}
