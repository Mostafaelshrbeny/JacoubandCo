import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/screens/AdminScreens/editcard.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_card_state.dart';

class EditCardCubit extends Cubit<EditCardState> {
  EditCardCubit() : super(EditCardInitial());
  static EditCardCubit get(context) => BlocProvider.of(context);
  showCard({required int option, required double cash}) async {
    // final SharedPreferences pref = await SharedPreferences.getInstance();

    if (option == 1) {
      shownumC = 1;
      showopC = "Shown";
      // cashCard(cash: cash, show: true);
    } else {
      shownumC = 2;
      showopC = "Hide";
      //cashCard(cash: cash, show: false);
    }
    pref.setInt('shownum', option);

    emit(EditCard());
  }

  showGroup(int option) async {
    if (option == 1) {
      pref.setString('gshow', "Shown");
    } else {
      pref.setString('gshow', 'Hide');
    }
    pref.setInt('gnum', option);

    emit(EditCard());
  }

  newGroupSHOW(int option) async {
    // final SharedPreferences pref = await SharedPreferences.getInstance();

    if (option == 1) {
      pref.setString('ngshow', "Shown");
    } else {
      pref.setString('ngshow', 'Hide');
    }
    pref.setInt('ngnum', option);

    emit(EditCard());
  }

  cashCard({required double cash, required bool? show}) async {
    emit(LoadSaveChangeCard());
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginbox!.get('token')}'
    };
    var data =
        json.encode({"cash_in_bank": cash, "show_cash_in_bank": show ?? true});
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/app-settings',
        options: Options(
          method: 'PATCH',
          headers: headers,
        ),
        data: data,
      );
      emit(SaveChangeDoneCard());
    } on DioException catch (e) {
      print(e.response);
      emit(FailSaveChangeCard());
    }
  }
}
