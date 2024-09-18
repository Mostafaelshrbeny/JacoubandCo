import 'dart:convert';

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/NetworkCubits/GroupMember/group_member_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupMemberCubit extends Cubit<GroupMemberState> {
  GroupMemberCubit() : super(InitialState());
  static GroupMemberCubit get(context) => BlocProvider.of(context);

  exitGroup({required int id}) async {
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
      emit(ExitDoneState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedToExitState());
    }
  }
}
