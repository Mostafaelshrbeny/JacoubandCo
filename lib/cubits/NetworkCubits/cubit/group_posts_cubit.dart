import 'dart:convert';

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/cubits/NetworkCubits/cubit/group_posts_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupPostsCubit extends Cubit<GroupPostsState> {
  GroupPostsCubit() : super(Initialstate());
  static GroupPostsCubit get(context) => BlocProvider.of(context);
  postReactions(
      {required String react,
      required int groupid,
      required int postid}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginbox!.get('token')}'
    };
    var data = json.encode({"reaction": react});
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/groups/$groupid/posts/$postid/reactions',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);
      emit(Reactedstate());
    } on DioException catch (e) {
      print(e.response);
    }
  }
}
