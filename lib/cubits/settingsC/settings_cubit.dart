import 'dart:convert';

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/settingsC/settings_state.dart';
import 'package:chatjob/cubits/settingsC/settingsmethods.dart';
import 'package:chatjob/main.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsCubitInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);

  moneyselect(int option) async {
    Loadingcurrstate();
    try {
      if (option == 1) {
        pref.setString('curname', "Kč");
        patchcur('czk');
      } else if (option == 2) {
        pref.setString('curname', 'USD');
        patchcur('usd');
      } else {
        pref.setString('curname', 'EUR');
      }
      pref.setInt('curr', option);

      emit(Changecurrstate());
    } catch (e) {
      emit(Failedcurrstate());
      print(e);
    }
  }

  langselect(int option, BuildContext cx) async {
    Loadinglangstate();
    try {
      if (option == 1) {
        pref.setString('lang', "English");
        patchlang('en');
        await cx.setLocale(const Locale('en', 'US'));
        emit(Changelangstate());
      } else {
        pref.setString('lang', "Czech");
        patchlang('cz');
        await cx.setLocale(const Locale('cs', 'CZ'));
        emit(Changelangstate());
      }
      pref.setInt('langnum', option);
      emit(Changelangstate());
    } catch (e) {
      print(e);
      emit(Failedlangstate());
    }
  }

  faceidselect(int option) async {
    emit(Loadingfacestate());
    try {
      if (option == 1) {
        pref.setString('face', "Enabled");
        patchface(true);
        emit(Changefacestate());
      } else {
        pref.setString('face', "Disabled");
        patchface(false);
        emit(Changefacestate());
      }
      pref.setInt('facenum', option);
      emit(Changestate());
    } on DioException catch (e) {
      print(e.response);
      emit(Failedfacestate());
    }
  }

  pinchat({required bool pined, required int id}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginbox!.get('token')}'
    };
    var data = json.encode({
      "is_pinned": pined,
    });
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/my-groups/$id/settings',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);
    } on DioException catch (e) {
      print(e.response);
    }
  }

  unreadchat({required bool unread, required int id}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginbox!.get('token')}'
    };
    var data = json.encode({
      "is_unread": unread,
    });
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/my-groups/$id/settings',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);
    } on DioException catch (e) {
      print(e.response);
    }
  }

  twostep({required bool tfa, String? pin}) async {
    emit(LoadingTwostate());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var data = FormData.fromMap({'tfa': tfa});
    pin == null
        ? null
        : data.fields.add(MapEntry<String, String>('tfa_pin', pin));
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/profile',
        options: Options(
          method: 'PATCH',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        emit(TwoStepDonestate());
        print(json.encode(response.data));
      }
    } on DioException catch (e) {
      emit(FailedTwostate());
      print(e.response);
    }
  }
}
