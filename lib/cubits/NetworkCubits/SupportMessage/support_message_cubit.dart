import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';

import 'package:chatjob/cubits/NetworkCubits/SupportMessage/support_message_state.dart';
import 'package:chatjob/screens/AdminScreens/SupportTickets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupportMessageCubit extends Cubit<SupportMessageState> {
  SupportMessageCubit() : super(InitialState());
  static SupportMessageCubit get(context) => BlocProvider.of(context);
  getAllSupportMessage() async {
    emit(LoadingAllSupMessageState());
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
      print(response.data);
      emit(GotAllSupMessageState());
    } on DioException catch (e) {
      print(e.response);
      emit(AllSupMessageFailedState());
    }
  }

  createSupMessage({required String subject, required String body}) async {
    emit(LoadingCreateSupState());
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginbox!.get('token')}'
    };
    var data = json.encode({"subject": subject, "body": body});
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/support-messages',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      emit(CreatedSupState());
    } on DioException catch (e) {
      print(e.response);
      emit(CreatSupFailedState());
    }
  }

  editSupMessage(
      {required int id,
      required bool open,
      required BuildContext context}) async {
    emit(LoadingEditSupState());
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginbox!.get('token')}'
    };
    var data = json.encode({"status": open ? 'open' : 'closed'});
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/support-messages/$id',
        options: Options(
          method: 'PATCH',
          headers: headers,
        ),
        data: data,
      );
      // print(await response.data);
      if (context.mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const SupportTicketsScreen()));
      }

      emit(EditedState());
    } on DioException catch (e) {
      print(e.response);
      emit(EditedSupFailedState());
    }
  }
}
