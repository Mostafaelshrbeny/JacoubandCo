import 'dart:convert';

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/models/notification_model.dart';
import 'package:dio/dio.dart';

getNotification() async {
  List<NotificationModel> notifications = [];
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/notifications',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    for (var element in response.data) {
      notifications.add(NotificationModel.fromJson(element));
    }
    return notifications;
  } on DioException catch (e) {
    print(e.response);
  }
}

readNotifications({required List ids}) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${loginbox!.get('token')}'
  };
  var data = json.encode({"ids": ids});
  try {
    var dio = Dio();
    var response = await dio.request(
      '${Constant.url}/notifications/mark-read',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    pref.setInt('Notification', 0);
  } on DioException catch (e) {
    print(e.response);
  }
}
