import 'dart:convert';

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/models/group_model.dart';

import 'package:dio/dio.dart';

muteGroupOption(
    {required int id,
    String? mute,
    String? savetoGallery,
    required Settings settings}) async {
  //unmute, one_week, two_weeks
  //default, always, never
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${loginbox!.get('token')}'
  };
  var data = json.encode({
    "mute": mute ?? settings.mute,
    "save_to_gallery": savetoGallery ?? settings.saveToGallery
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
