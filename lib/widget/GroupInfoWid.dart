import 'package:chatjob/cubits/NetworkCubits/GroupData/group_data_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/GroupData/group_data_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/refresh.dart';
import 'package:chatjob/models/users_model.dart';

import 'package:chatjob/widget/ImageWidget.dart';
import 'package:chatjob/widget/publicwid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMembers extends StatelessWidget {
  const AddMembers({
    super.key,
    required this.searchcont,
    required this.checked,
    required this.users,
    required this.members,
    required this.id,
    required this.cx,
    required this.wid,
  });
  final BuildContext cx;
  final Widget wid;
  final TextEditingController searchcont;
  final bool checked;
  final int id;
  final List<UsersModel> users;
  final List<UsersModel?>? members;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: const Color(0xFF0A2432),
            borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () => showModalBottomSheet(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 150),
            backgroundColor: const Color.fromARGB(255, 3, 27, 43),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            context: context,
            builder: (context) {
              return AddMember(
                cx: cx,
                wid: wid,
                searchcont: searchcont,
                checked: checked,
                users: users,
                members: members!,
                id: id,
              );
            },
          ),
          child: Row(
            children: [
              const Icon(
                Icons.add_circle_rounded,
                color: Color(0xFFAECDF8),
              ),
              const SizedBox(width: 4),
              Text(
                LocaleKeys.groupInfoAddParticipants.tr(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: const Color(0xFFAECDF8),
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class AddMember extends StatefulWidget {
  const AddMember({
    super.key,
    required this.searchcont,
    required this.checked,
    required this.users,
    required this.members,
    required this.id,
    required this.cx,
    required this.wid,
  });
  final BuildContext cx;
  final Widget wid;
  final TextEditingController searchcont;
  final bool checked;
  // final List<Map<dynamic, dynamic>> users, members;
  final List<UsersModel?>? users;
  final List<UsersModel?>? members;
  final int id;

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  @override
  void initState() {
    var x = setthelist();
    showusers();
    debugPrint("x ==> $x");
    super.initState();
  }

  List<UsersModel?>? usersShow;
  List<bool> boolList = [];
  List<int> listOfIds = [];
  List<int> listOfSimilarIds = [];
  bool isAddParticantsLoading = false;
  setthelist() {
    for (var element in widget.users!) {
      if (widget.members!.contains(element!.id)) {
        // if (widget.members.contains(element['id'])) {
        // listOfIds.add(value)
        boolList.add(true);
      } else {
        boolList.add(false);
      }
    }
    listOfSimilarIds = List.generate(
        widget.members!.length, (index) => widget.members![index]!.id!);
    debugPrint("======================================");
    debugPrint(listOfSimilarIds.toString());
    debugPrint("======================================");
    return boolList;
  }

  showusers() {
    setState(() {
      usersShow = widget.users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
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
                    LocaleKeys.groupInfoAddParticipants.tr(),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SearchRow(
            searchcont: widget.searchcont,
            label: LocaleKeys.groupInfoSearchParticipants.tr(),
            onchange: (p0) {
              usersShow = widget.users!
                  .where((element) => element!.name!.contains(p0))
                  .toList();
            },
          ),
        ),
        Expanded(
          child: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 350),
            margin:
                const EdgeInsets.only(right: 30, left: 30, bottom: 22, top: 22),
            decoration: BoxDecoration(
                color: const Color(0xFF0A2432),
                borderRadius: BorderRadius.circular(16)),
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // bool isInUsers = widget.members!.contains(element!.id);
                return AdditionalRow(
                  label: usersShow![index]!.name ?? 'no name',
                  // label: widget.users[index]['name'],
                  icon: SizedBox(
                    height: 24,
                    width: 24,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: usersShow![index]!.image == null
                            ? const Image(
                                image: AssetImage(
                                    'assets/images/no profilepic.png'))
                            : ImageWid(
                                imageUrl: usersShow![index]!.image!,
                                noImage: 'assets/images/no profilepic.png')),
                  ),

                  x: 0,
                  icon2: StatefulBuilder(
                    builder: (context, setState) => Checkbox(
                      activeColor: const Color(0xFF8E704F),
                      side:
                          const BorderSide(width: 1, color: Color(0xFFCFCECA)),
                      checkColor: const Color(0xFF0A2432),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      overlayColor:
                          const MaterialStatePropertyAll(Color(0xFF0A2432)),
                      onChanged: (value) {
                        setState(
                          () {
                            if (!listOfSimilarIds
                                .contains(usersShow![index]!.id!)) {
                              // listOfSimilarIds.removeWhere((element) =>
                              //     element == widget.users![index]!.id!);
                              listOfSimilarIds.add(usersShow![index]!.id!);
                              listOfIds.add(usersShow![index]!.id!);
                            } else if (listOfSimilarIds
                                    .contains(usersShow![index]!.id!) &&
                                listOfIds.contains(usersShow![index]!.id!)) {
                              listOfSimilarIds.removeWhere((element) =>
                                  element == usersShow![index]!.id!);
                            }
                          },
                        );
                      },
                      value: listOfSimilarIds.contains(usersShow![index]!.id!),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemCount: usersShow!.length,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => GroupDataCubit(),
          child: BlocConsumer<GroupDataCubit, GroupDataState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 55, right: 40, left: 40),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      isAddParticantsLoading = true;
                    });
                    listOfIds.isEmpty
                        ? null
                        : await GroupDataCubit.get(context)
                            .addMember(ids: listOfIds, id: widget.id);

                    if (context.mounted) {
                      Navigator.pop(context);
                      refreshs(widget.cx, widget.wid);
                    }
                  },
                  child: Container(
                      height: 50,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(142, 112, 79, 1),
                          borderRadius: BorderRadius.circular(70)),
                      width: MediaQuery.sizeOf(context).width - 20,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: isAddParticantsLoading
                            ? Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: MediaQuery.of(context).size.width / 15,
                                child: const CircularProgressIndicator(
                                  color: Color.fromRGBO(10, 36, 50, 1),
                                ),
                              )
                            : Text(
                                LocaleKeys.groupInfoAddParticipants.tr(),
                                softWrap: false,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        color: const Color(0xFFCFCECA),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                              ),
                      )),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SearchRow extends StatelessWidget {
  const SearchRow({
    super.key,
    required this.searchcont,
    required this.label,
    required this.onchange,
  });
  final String label;
  final TextEditingController searchcont;
  final Function(String)? onchange;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 22),
      decoration: BoxDecoration(
          color: const Color(0xFF0A2432),
          borderRadius: BorderRadius.circular(16)),
      height: 42,
      width: double.infinity,
      child: TextFormField(
        onChanged: onchange,
        controller: searchcont,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 2),
            prefixIcon: const Icon(
              Icons.search,
              size: 28,
              color: Color(0xFFAECEF8),
            ),
            //fillColor: const Color.fromARGB(255, 15, 57, 80),
            hintText: label,
            hintStyle: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: const Color(0xFFAECEF8)),
            border: InputBorder.none),
      ),
    );
  }
}
