import 'dart:io';

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/models/commentmodel.dart';
import 'package:chatjob/models/messages_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

getGroupPosts({required int id, int page = 1}) async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  MessagesModel? posts;
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/groups/$id/posts?page=$page',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    posts = MessagesModel.fromJson(response.data);
    return posts;
  } on DioException catch (e) {
    print(e.response);
  }
}

getPostComments({required int groupid, required int postid, int? page}) async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  List<CommentsModel> comments = [];
  try {
    var response = await dio.request(
      page == null
          ? '${Constant.url}/groups/$groupid/posts/$postid/comments'
          : '${Constant.url}/groups/$groupid/posts/$postid/comments?id=$page',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    for (var element in response.data) {
      comments.add(CommentsModel.fromJson(element));
    }
    return comments;
  } on DioException catch (e) {
    print(e.response);
  }
}

deletePost({required int postid, required int groupid}) async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/groups/$groupid/posts/$postid',
      options: Options(
        method: 'DELETE',
        headers: headers,
      ),
    );
  } on DioException catch (e) {
    print(e.response);
  }
}

readPost({required int postid, required int groupid}) async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/groups/$groupid/posts/$postid/mark-read',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
    );
  } on DioException catch (e) {
    print(e.response);
  }
}
