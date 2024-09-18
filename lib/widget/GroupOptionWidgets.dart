import 'package:chatjob/cubits/GroupInfo/group_info_cubit.dart';
import 'package:chatjob/cubits/GroupInfo/group_info_state.dart';
import 'package:chatjob/cubits/NetworkCubits/GroupData/group_data_cubit.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/refresh.dart';
import 'package:chatjob/screens/groupchat/groupinfo.dart';

import 'package:chatjob/widget/publicwid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({
    super.key,
    required this.muteop,
    required this.mutenum,
    required this.scub,
    required this.widget,
    required this.savenum,
    required this.saveop,
    required this.id,
    required this.settings,
  });

  final String? muteop;
  final dynamic settings;
  final int id;
  final int? mutenum;
  final GroupDataCubit scub;
  final GroupInfoScreen widget;
  final int? savenum;

  final String? saveop;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupInfoCubit, GroupInfoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var optioncubit = GroupInfoCubit.get(context);
        return Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(top: 22),
          decoration: BoxDecoration(
              color: const Color(0xFF0A2432),
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Builder(builder: (cx) {
                return AdditionalRow(
                    x: 0,
                    label: LocaleKeys.groupInfomutemuteGroup.tr(),
                    icon: const Icon(
                      Icons.volume_off,
                      size: 24,
                      color: Color(0xFFAECEF8),
                    ),
                    icon2: Text(
                      muteop == null ? '' : muteop!,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: const Color(0xFFCFCECA),
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
                    ontap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: const Color.fromARGB(255, 3, 27, 43),
                          context: cx,
                          builder: (context) {
                            return MuteOptions(
                              mutenum: mutenum,
                              scub: optioncubit,
                              widget: widget,
                              cx: cx,
                              settings: settings,
                            );
                          });
                    });
              }),
              const Padding(
                padding: EdgeInsets.only(right: 0, left: 30),
                child: Divider(
                  thickness: 1,
                ),
              ),
              Builder(builder: (cz) {
                return AdditionalRow(
                    x: 0,
                    label: LocaleKeys.groupInfoSaveMediaSETTSaveMedia.tr(),
                    icon: const FaIcon(
                      FontAwesomeIcons.download,
                      size: 22,
                      color: Color(0xFFAECEF8),
                    ),
                    ontap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: const Color.fromARGB(255, 3, 27, 43),
                          context: cz,
                          builder: (context) {
                            return SaveOptions(
                              cz: cz,
                              savenum: savenum,
                              scub: optioncubit,
                              widget: widget,
                              id: id,
                              setting: settings,
                            );
                          });
                    },
                    icon2: Text(
                      saveop == null
                          ? ''
                          : saveop![0].toUpperCase() + saveop!.substring(1),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: const Color(0xFFCFCECA),
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ));
              }),
            ],
          ),
        );
      },
    );
  }
}

class SaveOptions extends StatelessWidget {
  const SaveOptions({
    super.key,
    required this.savenum,
    required this.scub,
    required this.widget,
    required this.cz,
    required this.id,
    required this.setting,
  });

  final int? savenum;
  final GroupInfoCubit scub;
  final GroupInfoScreen widget;
  final BuildContext cz;
  final int id;
  final dynamic setting;

  @override
  Widget build(BuildContext context) {
    return BottomSheetOptions(
      seleted1: savenum,
      cx: cz,
      onchange3: () {
        scub.saveOptions(id: widget.id, option: 3, settings: setting);

        Navigator.pop(context);
        refreshs(context, widget);
      },
      onchange2: () {
        scub.saveOptions(id: widget.id, option: 2, settings: setting);

        Navigator.pop(context);
        refreshs(context, widget);
      },
      onchange1: () {
        scub.saveOptions(id: widget.id, option: 1, settings: setting);

        Navigator.pop(context);
        refreshs(context, widget);
      },
      label: LocaleKeys.groupInfoSaveMediaSETTSaveMedia.tr(),
      option2: LocaleKeys.groupInfoSaveMediaSETTAlwaysSave.tr(),
      option3: LocaleKeys.groupInfoSaveMediaSETTNotSave.tr(),
      option1: LocaleKeys.groupInfoSaveMediaSETToff.tr(),
    );
  }
}

class MuteOptions extends StatelessWidget {
  const MuteOptions({
    super.key,
    required this.mutenum,
    required this.scub,
    required this.widget,
    required this.cx,
    required this.settings,
  });

  final int? mutenum;
  final dynamic settings;
  final GroupInfoCubit scub;
  final GroupInfoScreen widget;
  final BuildContext cx;

  @override
  Widget build(BuildContext context) {
    return BottomSheetOptions(
      seleted1: mutenum,
      cx: cx,
      onchange1: () {
        scub.muteOptions(option: 1, id: widget.id, settings: settings);

        Navigator.pop(context);
        refreshs(context, widget);
      },
      onchange2: () {
        scub.muteOptions(option: 2, id: widget.id, settings: settings);

        Navigator.pop(context);
        refreshs(context, widget);
      },
      onchange3: () {
        scub.muteOptions(option: 3, id: widget.id, settings: settings);

        Navigator.pop(context);
        refreshs(context, widget);
      },
      label: LocaleKeys.groupInfomutemuteGroup.tr(),
      option2: LocaleKeys.groupInfomuteoneweek.tr(),
      option3: LocaleKeys.groupInfomutetwoweek.tr(),
      option1: LocaleKeys.groupInfomuteNomute.tr(),
    );
  }
}
