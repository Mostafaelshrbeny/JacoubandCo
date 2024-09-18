import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/models/allgroups_model.dart';
import 'package:chatjob/models/group_model.dart';
import 'package:dio/dio.dart';

getAdminallGroup() async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  List<AllGroupsModel>? groups = [];
  try {
    var response = await dio.request(
      '${Constant.url}/groups',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    for (var element in response.data) {
      groups.add(AllGroupsModel.fromJson(element));
    }
    return groups;
  } on DioException catch (e) {
    print(e.response);
  }
}

getMyAllGroups() async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  List<AllGroupsModel> groups = [];
  try {
    var response = await dio.request(
      '${Constant.url}/my-groups',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    for (var element in response.data) {
      groups.add(AllGroupsModel.fromJson(element));
    }
    return groups;
  } on DioException catch (e) {
    print(e.response);
  }
}

getMyGroupData({required int id}) async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  GroupModel? groupModel;
  try {
    var response = await dio.request(
      '${Constant.url}/my-groups/$id',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    groupModel = GroupModel.fromJson(response.data);
    return groupModel;
  } on DioException catch (e) {
    print(e.response);
  }
}

Future<GroupModel> getGroupmembers({required int id}) async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  GroupModel? groupModel;
  try {
    var response = await dio.request(
      '${Constant.url}/my-groups/$id',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    groupModel = GroupModel.fromJson(response.data);
    return groupModel;
  } on DioException catch (e) {
    print(e.response);
    return groupModel!;
  }
}
