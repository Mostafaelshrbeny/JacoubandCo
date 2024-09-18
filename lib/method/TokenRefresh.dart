import 'package:chatjob/Hive/localdata.dart';
import 'package:dio/dio.dart';

refreshToken() async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/auth/refresh-token',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
    );
    // print(response.data['access_token']);
    loginbox!.put('token', response.data['access_token']);
  } on DioException catch (e) {
    print(e.response);
  }
}
