import 'dart:io';

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/NetworkCubits/company/company_apis_state.dart';
import 'package:chatjob/method/network.dart';
import 'package:chatjob/screens/mainscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';

class CompanyApisCubit extends Cubit<CompanyApisState> {
  CompanyApisCubit() : super(Initialstate());

  CompanyApisCubit get(context) => BlocProvider.of(context);

  createcompany({
    required BuildContext context,
    required String name,
    required double cashinbank,
    required String opensea,
    required String facebook,
    required String discord,
    required String instagram,
    required String website,
    required String category,
    required String desc,
    required File? image,
    required bool active,
    required String? color,
  }) async {
    final String newPath = image != null ? image.path.split('/').last : '';
    emit(Loadingstate());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var data = FormData.fromMap({
      'name': name,
      'active': active,
      'cash_in_bank': cashinbank,
      'description': desc,
      'color': color,
      'image': image == null
          ? null
          : await MultipartFile.fromFile(image.path,
              filename: newPath, contentType: MediaType('image', 'jpg')),
      'category': category,
      'website': website,
      'open_sea': opensea,
      'instagram': instagram,
      'facebook': facebook,
      'discord': discord
    });

    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/companies',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);
      // getcompanies(loginbox!.get('token'));
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const Mainscreen(inApp: true)),
            (route) => false);
      }
      emit(Addedstate());
    } on DioException catch (e) {
      print(e.response!.data);
      emit(Failedstate());
    }
  }

  editcompant({
    required BuildContext context,
    required int id,
    required File? image,
    required String name,
    required double cashinbank,
    required String color,
    required String? opensea,
    required String? facebook,
    required String? discord,
    required String? instagram,
    required String? website,
    required String? category,
    required String? desc,
    required bool active,
  }) async {
    final String newPath = image == null ? '' : image.path.split('/').last;
    FormData data = FormData.fromMap({
      'name': name,
      'active': active,
      'color': color,
      'cash_in_bank': cashinbank,
      'description': desc,
      'category': category,
      'website': website,
      'open_sea': opensea,
      'instagram': instagram,
      'facebook': facebook,
      'discord': discord
    });
    if (image != null) {
      MultipartFile file = await MultipartFile.fromFile(
        image.path,
        filename: newPath,
        contentType: MediaType('image', 'jpg'),
      );

      data.files.add(MapEntry<String, MultipartFile>('image', file));
    }
    emit(Loadingeditstate());
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var dio = Dio();
    try {
      var response = await dio.request('${${Constant.url}}/companies/$id',
          options: Options(
            method: 'PATCH',
            headers: headers,
          ),
          data: data);
      print(response.data);
      // getcompanies(loginbox!.get('token'));
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => const Mainscreen(
                      inApp: true,
                    )),
            (route) => false);
      }

      emit(Editedstate());
    } on DioException catch (e) {
      print(e.response!.data['message']);
    }
  }

  deletecompany(int id, BuildContext context) async {
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/companies/$id',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );
      print(await response.data);
      if (context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => const Mainscreen(
                      inApp: true,
                    )));
      }
    } on DioException catch (e) {
      print(e.response);
    }
  }
}
