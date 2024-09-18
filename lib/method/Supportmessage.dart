import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:dio/dio.dart';

oneSupMessage({required int id}) async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/support-messages/$id',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    return response.data;
  } on DioException catch (e) {
    print(e.response);
  }
}
