import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/NetworkCubits/api/api_state.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/method/network.dart';
import 'package:chatjob/screens/loginscreens/login.dart';
import 'package:chatjob/screens/loginscreens/updatepassword.dart';
import 'package:chatjob/screens/loginscreens/verfication.dart';
import 'package:chatjob/screens/mainscreen.dart';
import 'package:chatjob/screens/twolog.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Apicubit extends Cubit<Apistate> {
  Apicubit() : super(Initialstate());
  static Apicubit get(context) => BlocProvider.of(context);

  bool load = false;
  String err = '';
  var dio = Dio();
  loadi(bool lo) {
    load = lo;
    emit(Forgetstate());
  }

  log(String data, BuildContext context) async {
    emit(Loginloading());
    Response res = await loginfun(dio, data);
    if (res.statusCode == 200) {
      var user = res.data;
      // print('User data $user');
      if (context.mounted) {
        await context.setLocale(user['lang'] == 'en'
            ? const Locale('en', 'US')
            : const Locale('cs', 'CZ'));
      }
      pref.setString('lang', user['lang'] == 'en' ? 'English' : 'Czech');
      pref.setInt('langnum', user['lang'] == 'en' ? 1 : 2);
      pref.setString('face', user['face_id'] ? 'Enabled' : 'Disabled');
      pref.setInt('facenum', user['face_id'] ? 1 : 2);
      pref.setString('TwoS', user['tfa'] ? "ON" : "OFF");
      pref.setString(
          "wallpaper",
          user["wallpaper"] == null
              ? "${Constant.url}/uploads/1704206389284.jpg"
              : user["wallpaper"]['url']);
      switch (user['currency']) {
        case 'usd':
          {
            pref.setString('curname', "USD");
            pref.setInt('curr', 2);
          }
          break;

        case 'czk':
          {
            pref.setString('curname', "Kč");
            pref.setInt('curr', 1);
          }
          break;

        default:
          {
            pref.setString('curname', 'EUR');
            pref.setInt('curr', 3);
          }
          break;
      }

      await getprofile(user['access_token']);
      if (context.mounted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Mainscreen()));
      }
      loadi(false);
      emit(Loginstate());
    } else {
      err = res.data['message'].toString();

      loginbox!.put('key', err);
      loadi(false);
      emit(Loginfailed());
    }
  }

  /*forget(var data, BuildContext context, {required code}) async {
    Response res = await forgetpass(dio, data);
    if (res.statusCode == 200) {
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const Verificationscreen();
        }));
      }
    }
    print(res.statusCode);
    emit(Forgetstate());
  }*/

  /* verify({required String code, required BuildContext context}) async {
    emit(Verifyloading());
    Response res = await verifycode(code);
    if (res.statusCode == 200) {
      if (context.mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Updatepassreen()));
        emit(Verifystate());
      }
    } else {
      if (context.mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Updatepassreen()));
        emit(Verifyfailed());
      }
    }
  }*/

  /* changepassword(
      {required String code,
      required String pass,
      required String confpass}) async {
    Response res = await changepass(code: code, pass: pass, confpass: confpass);
    if (res.statusCode == 200) {}
  }*/

  getprofile(String token) async {
    var headers = {'Authorization': 'Bearer $token'};
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
      pref.setInt('Notification', response.data['notifications_count']);
    } on DioException catch (e) {
      print(e.response!.data['message']);
    }
  }

  /* passwordic() {
    hidden = !hidden;
  }*/
}
