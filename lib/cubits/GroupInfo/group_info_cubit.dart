import 'package:chatjob/cubits/GroupInfo/group_info_state.dart';
import 'package:chatjob/cubits/GroupInfo/method.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/models/group_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
//TODO MOVE FOR ANOTHER CUBIT

class GroupInfoCubit extends Cubit<GroupInfoState> {
  GroupInfoCubit() : super(GroupInfoInitial());

  static GroupInfoCubit get(context) => BlocProvider.of(context);

  muteOptions(
      {required int option,
      required int id,
      required Settings settings}) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
//unmute, one_week, two_weeks

    if (option == 1) {
      pref.setString('muteop', "Unmute");
      muteGroupOption(
        id: id,
        mute: 'unmute',
        settings: settings,
      );
    } else if (option == 2) {
      pref.setString('muteop', '1 week');
      muteGroupOption(id: id, mute: 'one_week', settings: settings);
    } else {
      pref.setString('muteop', '2 weeks');
      muteGroupOption(id: id, mute: 'two_weeks', settings: settings);
    }
    pref.setInt('mutenum', option);

    emit(ChangeMuteOption());
  }

  saveOptions(
      {required int option, required int id, required dynamic settings}) async {
    //default, always, never
    if (option == 1) {
      muteGroupOption(id: id, savetoGallery: 'default', settings: settings);
    } else if (option == 2) {
      muteGroupOption(id: id, savetoGallery: 'always', settings: settings);
    } else {
      muteGroupOption(id: id, savetoGallery: 'never', settings: settings);
    }

    emit(ChangeGalleryOption());
  }
}
