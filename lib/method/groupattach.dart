import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/models/mediamodel.dart';
import 'package:dio/dio.dart';

getGroupMedia({required int groupid, required String type}) async {
  MediaModel? media;
  try {
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var dio = Dio();
    var response = await dio.request(
      '${Constant.url}/groups/$groupid/attachments?type=$type',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    media = MediaModel.fromJson(response.data);
    return media;
  } on DioException catch (e) {
    print(e.response);
  }
}
