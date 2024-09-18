import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/models/Profile_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/users_model.dart';

Future<List<UsersModel>> getallUsers() async {
  List<UsersModel> usersList;
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/users',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    usersList = await (response.data)
        .map<UsersModel>((x) => UsersModel.fromJson(x))
        .toList() as List<UsersModel>;
    debugPrint('======');
    debugPrint(usersList.toString());
    debugPrint('======');
    return usersList;
  } on DioException catch (e) {
    print(e.response);
    return [];
  } catch (e) {
    debugPrint(e.toString());
    return [];
  }
}

Future<UsersModel> getUserinfo({required int id}) async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/users/$id',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    return UsersModel.fromJson(response.data);
  } on DioException catch (e) {
    print(e.response);
    return UsersModel.fromJson(e.response!.data);
  }
}

getTheProfile() async {
  ProfileModel profile = ProfileModel();
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/profile',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    loginbox!.put('User', response.data);
    print('Nmae is ${response.data['name']}');
    pref.setString('UserName', response.data['name']);
    pref.setString('TwoS', response.data['tfa'] ? "ON" : "OFF");

    profile = ProfileModel.fromJson(response.data);
    pref.setInt('Notification', profile.notificationsCount!);
    // return profile;
  } on DioException catch (e) {
    print(e.response!.data['message']);
  }
}
