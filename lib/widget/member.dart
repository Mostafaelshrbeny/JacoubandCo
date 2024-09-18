import 'package:chatjob/cubits/NetworkCubits/GroupData/group_data_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/GroupData/group_data_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/refresh.dart';
import 'package:chatjob/models/users_model.dart';
import 'package:chatjob/screens/AdminScreens/MemberInfo.dart';

import 'package:chatjob/widget/ImageWidget.dart';
import 'package:chatjob/widget/publicwid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Memberpress extends StatefulWidget {
  const Memberpress({
    super.key,
    required this.userinfo,
    required this.groupId,
    required this.cx,
    required this.wid,
    required this.admin,
  });
  final UsersModel userinfo;
  final Widget wid;
  final BuildContext cx;
  final int groupId;
  final bool admin;

  @override
  State<Memberpress> createState() => _MemberpressState();
}

class _MemberpressState extends State<Memberpress> {
  bool x = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: Stack(
            children: [
              Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Text(
                    widget.userinfo.name ?? 'no name',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFF9F9F9)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromRGBO(10, 36, 50, 1)),
          child: AdditionalRow(
              ontap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MemberInfoScreen(
                            id: widget.userinfo.id!,
                            gId: widget.groupId,
                            admin: widget.admin,
                          ))),
              label: LocaleKeys.groupInfoUserInfo.tr(),
              icon: const Icon(
                Icons.info,
                color: Color(0xFFAECDF8),
              ),
              x: 0),
        ),
        BlocProvider(
          create: (context) => GroupDataCubit(),
          child: BlocConsumer<GroupDataCubit, GroupDataState>(
            listener: (context, state) {
              if (state is MemberDeletedState) {
                Navigator.pop(widget.cx);
                refreshs(widget.cx, widget.wid);
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromRGBO(10, 36, 50, 1)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      x = true;
                    });
                    GroupDataCubit.get(context).deleteMember(
                        ids: [widget.userinfo.id], id: widget.groupId);
                  },
                  child: x
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFFF80909)),
                        )
                      : Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: Icon(
                                Icons.cancel,
                                color: Color(0xFFF80909),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: Text(
                                LocaleKeys.groupInfoRemovefromGroup.tr(),
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
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 166)
      ],
    );
  }
}

class MembersRow extends StatelessWidget {
  const MembersRow({
    super.key,
    required this.label,
    required this.memberimage,
    required this.ontap,
    required this.admin,
    required this.id,
    required this.userid,
  });
  final int id, userid;
  final String label;
  final String? memberimage;
  final bool admin;

  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: admin && userid != id ? ontap : null,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12),
        child: Row(
          children: [
            memberimage == null
                ? Container(
                    height: 24,
                    width: 24,
                    margin: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: AssetImage(memberimage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : ImageWid(
                    imageUrl: memberimage!,
                    noImage: 'assets/images/no profilepic.png',
                    height: 24,
                    width: 24,
                    margin: const EdgeInsets.only(right: 8),
                  ),
            /*Container(
                    height: 24,
                    width: 24,
                    margin: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ,
                      ),
                    )*/

            Text(
              id == userid ? 'You' : label,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFCFCECA)),
            ),
            const Spacer(),
            admin && id != userid
                ? const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xFFCFCECA),
                        size: 18,
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
