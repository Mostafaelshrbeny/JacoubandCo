import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/NetworkCubits/GroupData/group_data_state.dart';

import 'package:chatjob/screens/mainscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';

class GroupDataCubit extends Cubit<GroupDataState> {
  GroupDataCubit() : super(InitialState());
  static GroupDataCubit get(context) => BlocProvider.of(context);

  createGroup(
      {required String name,
      required BuildContext cx,
      required String bio,
      required bool active,
      required File? image}) async {
    final String newPath = image == null ? "" : image.path.split('/').last;
    emit(LoadingCreateState());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var data = FormData.fromMap({
      'name': name,
      'active': active,
      'description': bio,
      'image': image == null
          ? null
          : await MultipartFile.fromFile(image.path,
              filename: newPath, contentType: MediaType('image', 'jpg')),
    });

    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/groups',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);
      if (cx.mounted) {
        Navigator.pushAndRemoveUntil(
            cx,
            MaterialPageRoute(
                builder: (_) => const Mainscreen(
                      inApp: true,
                    )),
            (route) => false);
      }
      emit(CreatedState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedToCreateState());
    }
  }

  exitGroup({required int id, required BuildContext context}) async {
    emit(LoadingExitState());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/my-groups/$id',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      print(response.data);
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => const Mainscreen(
                      inApp: true,
                    )),
            (route) => false);
      }
      emit(ExitDoneState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedToExitState());
    }
  }

  editGroup(
      {required String name,
      required int id,
      required BuildContext cx,
      required String bio,
      required bool active,
      required File? image}) async {
    final String newPath = image == null ? "" : image.path.split('/').last;
    emit(LoadingEditState());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var data = FormData.fromMap({
      'image': image == null
          ? null
          : await MultipartFile.fromFile(image.path,
              filename: newPath, contentType: MediaType('image', 'jpg')),
      'name': name,
      'active': active,
      'description': bio
    });

    try {
      var dio = Dio();
      var response = await dio.request(
        '${Constant.url}/groups/$id',
        options: Options(
          method: 'PATCH',
          headers: headers,
        ),
        data: data,
      );
      if (cx.mounted) {
        Navigator.pushAndRemoveUntil(
            cx,
            MaterialPageRoute(
                builder: (_) => const Mainscreen(
                      inApp: true,
                    )),
            (route) => false);
      }
      emit(EditedState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedToEditState());
    }
  }

  deleteGroup({required int id, required BuildContext context}) async {
    emit(LoadingDeleteState());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/groups/$id',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      print(response.data);
      if (context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => const Mainscreen(
                      inApp: true,
                    )));
      }
      emit(DeletedState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedToDeleteState());
    }
  }

  addMember({required List ids, required int id}) async {
    emit(LoadingADDState());
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginbox!.get('token')}'
    };
    var data = json.encode({"users_ids": ids});
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/groups/$id/participants',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);
      emit(ADDEDState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedToADDState());
    }
  }

  deleteMember({required List ids, required int id}) async {
    emit(LoadingDelState());
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginbox!.get('token')}'
    };
    var data = json.encode({"users_ids": ids});
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/groups/$id/participants',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);
      emit(MemberDeletedState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedDelState());
    }
  }
}
