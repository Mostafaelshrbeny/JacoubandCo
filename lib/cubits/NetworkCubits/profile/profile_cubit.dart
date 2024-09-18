import 'dart:convert';
import 'dart:io';

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/NetworkCubits/profile/profile_state.dart';
import 'package:chatjob/main.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Profilecubit extends Cubit<ProfileState> {
  Profilecubit() : super(Initialstate());
  static Profilecubit get(context) => BlocProvider.of(context);
  bool load = false;
  loadi(bool lo) {
    load = lo;
    emit(LoadingState());
  }

  editprofile(
      {required XFile? image,
      required String name,
      required String bio,
      required String phone,
      required String city}) async {
    emit(Loadingstate());
    /*  List<int> fileBytes = await image.readAsBytes();
    String base64Avatar = base64Encode(fileBytes);*/
    final String newPath = image == null ? '' : image.path.split('/').last;

    var data = image == null
        ? FormData.fromMap({
            'name': name,
            'phone': phone,
            'city': city,
            'bio': bio,
          })
        : FormData.fromMap({
            'name': name,
            'phone': phone,
            'city': city,
            'bio': bio,
            'image': await MultipartFile.fromFile(image.path,
                filename: newPath, contentType: MediaType('image', 'jpg'))
          });

    var headers = {
      'Authorization': 'Bearer ${loginbox!.get('token')}',
      'Content-Type': 'multipart/form-data'
    };
    var dio = Dio();
    try {
      var response = await dio.patch('${Constant.url}/profile',
          options: Options(
            method: 'PATCH',
            headers: headers,
          ),
          data: data);
      print(response.data);
      loginbox!.put('User', response.data);
      pref.setString("Userimage", response.data['image']);
      emit(Editprofilstate());
    } on DioException catch (e) {
      print(e.response);
      //  print(base64Avatar);
      emit(Failedloginstate());
    }
  }

  edituser(
      {required XFile? image,
      required String name,
      required String bio,
      required String phone,
      required int id,
      required String city}) async {
    final String newPath = image == null ? '' : image.path.split('/').last;

    var data = image == null
        ? FormData.fromMap({
            'name': name,
            'phone': phone,
            'city': city,
            'bio': bio,
          })
        : FormData.fromMap({
            'name': name,
            'phone': phone,
            'city': city,
            'bio': bio,
            'image': await MultipartFile.fromFile(image.path,
                filename: newPath, contentType: MediaType('image', 'jpg'))
          });
    var headers = {
      'Authorization': 'Bearer ${loginbox!.get('token')}',
      'Content-Type': 'multipart/form-data'
    };
    var dio = Dio();
    try {
      var response = await dio.request('${Constant.url}/users/$id',
          options: Options(
            method: 'PATCH',
            headers: headers,
          ),
          data: data);

      print(response.data);
      emit(Editprofilstate());
    } on DioException catch (e) {
      print(e.response!.data['message']);
      emit(Failedloginstate());
    }
  }

  String? error;
  changepass({
    required String old,
    required String newpass,
    required String confirmNew,
  }) async {
    emit(LoadingPassState());
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginbox!.get('token')}'
    };
    var data = json.encode({
      "old_password": old,
      "new_password": newpass,
      "confirm_new_password": confirmNew
    });
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/profile/change-password',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      loadi(false);
      emit(ChangePassState());
    } on DioException catch (e) {
      print(e.response!.data['message']);
      loadi(false);
      emit(FailedChangeState());
    }
  }

  deleteUser({required int id}) async {
    emit(LoadingDeleteUserState());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/users/$id',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      emit(DeleteUserState());
    } on DioException catch (e) {
      print(e);
      emit(FailedDeleteUserState());
    }
  }
}


/*class ToImageData {
  static String imagetoData(String? imagepath) {
    final extension = path.extension(
      imagepath!.substring(imagepath.lastIndexOf("/")).replaceAll("/", ""),
    );
    final bytes = File(imagepath).readAsBytesSync();
    String base64 =
        "data:image/${extension.replaceAll(".", "")};base64,${base64Encode(bytes)}";
    return base64;
  }
}*/