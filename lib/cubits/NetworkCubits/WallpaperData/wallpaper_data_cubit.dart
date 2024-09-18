import 'dart:io';

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/NetworkCubits/WallpaperData/wallpaper_data_state.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/models/wallpaper_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class WallpaperDataCubit extends Cubit<WallpaperDataState> {
  WallpaperDataCubit() : super(InitialState());
  static WallpaperDataCubit get(context) => BlocProvider.of(context);

  createWallpaper({required File wallpaper, required bool used}) async {
    final String newPath = wallpaper.path.split('/').last;
    emit(LoadingCreateState());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var data = FormData.fromMap({
      'image': await MultipartFile.fromFile(wallpaper.path,
          filename: newPath, contentType: MediaType('image', 'jpg')),
      'is_used': used
    });

    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/profile/create-wallpaper',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      pref.setString("wallpaper", response.data["url"]);
      print(response.data);
      emit(CreateWallState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedCreateState());
    }
  }

  /* getWallpaper() async {
    emit(LoadingWallpaperState());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var dio = Dio();
    try {
      var response = await dio.request(
        '${${Constant.url}}wallpapers',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      print(response.data);
      emit(GetWallpaperState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedWallpaperState());
    }
  }*/

  createWallpaperAdmin({required File wallpaper, int? id}) async {
    final String newPath = wallpaper.path.split('/').last;
    emit(LoadingAdminCreateState());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var data = FormData.fromMap({
      'image': await MultipartFile.fromFile(wallpaper.path,
          filename: newPath, contentType: MediaType('image', 'jpg'))
    });

    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/wallpapers',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      emit(CreateAdminWallState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedAdminCreateState());
    }
  }

  deleteWallpaper() async {
    emit(LoadingDeleteState());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var dio = Dio();
    try {
      // var response =
      await dio.request(
        '${Constant.url}/wallpapers/:id',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      print('Deleted');
      emit(DeleteWallpaperState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedDeleteState());
    }
  }

  addwallpaperbutton() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    wallpapers!.add(WallpaperModel.fromJson({
      'url': pickedimage!.path.toString(),
      'id': wallpapers!.last.id!.toInt() + 1,
      'changed': true
    }));
    selectedimages.add(pickedimage.path.toString());

    emit(AddWallpaperButton());
  }

  savechanges() async {
    if (selectedimages.isNotEmpty) {
      for (var element in selectedimages) {
        createWallpaperAdmin(
          wallpaper: File(element),
        );
      }
    }
  }

  changeUserWallpaper({required int id}) async {
    emit(LoadingChangeUserState());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var data = FormData.fromMap({'wallpaper_id': '$id'});

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
      pref.setString("wallpaper", response.data['wallpaper']['url']);
      print(response.data);
      emit(ChangeUserWallpaperState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedChangeUserState());
    }
  }
}
