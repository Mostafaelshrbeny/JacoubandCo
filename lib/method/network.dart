import 'dart:convert';

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/models/company_model.dart';
import 'package:chatjob/screens/loginscreens/login.dart';
import 'package:chatjob/screens/loginscreens/updatepassword.dart';
import 'package:chatjob/screens/loginscreens/verfication.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

forgetpass({required String email, required BuildContext cx}) async {
  var headers = {'Content-Type': 'application/json'};
  var data = json.encode({"email": email});
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/auth/forgot-password',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    if (cx.mounted) {
      Navigator.push(cx, MaterialPageRoute(builder: (_) {
        return Verificationscreen(
          email: email,
        );
      }));
    }
    print(json.encode(response.data));
  } on DioException catch (e) {
    print(e.response);
  }
}

Future loginfun(Dio dio, String data) async {
  var headers = {'Content-Type': 'application/json'};

  try {
    var response = await dio.request(
      '${Constant.url}/auth/login',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    loginbox!.put('token', response.data['access_token']);
    response.data['role'] == 'admin'
        ? loginbox!.put('Admin', true)
        : loginbox!.put('Admin', false);
    loginbox!.put('id', response.data['id']);
    pref.setString('Userimage', response.data['image']);

    return response;
  } on DioException catch (e) {
    if (e.response != null) {
      return e.response;
    } else {
      print(e);
    }
  }
}

Future verifycode(String code, BuildContext context, String email) async {
  var headers = {'Content-Type': 'application/json'};
  var data = json.encode({"code": code});
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/auth/verify-otp',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    if (context.mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Updatepassreen(
                    code: code,
                    email: email,
                  )));
    }
    return response;
  } on DioException catch (e) {
    return e.response;
  }
}

changepass(
    {required String code,
    required String pass,
    required String confpass,
    required BuildContext context}) async {
  try {
    var headers = {'Content-Type': 'application/json'};
    var data = json
        .encode({"code": code, "password": pass, "confirm_password": confpass});
    var dio = Dio();
    var response = await dio.request(
      '${Constant.url}/auth/change-forgotten-password',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const Loginscreen()),
          (route) => false);
    }
    return response;
  } on DioException catch (e) {
    return e.response;
  }
}

getcompanies(String token) async {
  List<CompanyModel> companiesList = [];
  var headers = {'Authorization': 'Bearer $token'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/companies',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    //loginbox!.put('Companies', response.data);
    print(response.data);
    for (var element in response.data) {
      companiesList.add(CompanyModel.fromJson(element));
    }
    return companiesList;
  } on DioException catch (e) {
    print(e.response!.data['message']);
  }
}

getmessages() async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/support-messages',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    //print('support=${response.data}');
    return response.data;
  } on DioException catch (e) {
    print(e.response);
  }
}
