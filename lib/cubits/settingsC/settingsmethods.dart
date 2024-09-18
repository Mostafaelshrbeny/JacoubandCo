import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:dio/dio.dart';

patchlang(String lang) async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var data = FormData.fromMap({'lang': lang});

  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/profile',
      options: Options(
        method: 'PATCH',
        headers: headers,
      ),
      data: data,
    );

    print(response.data['lang']);
  } on DioException catch (e) {
    print(e.response);
  }
}

patchface(bool enable) async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var data = FormData.fromMap({'face_id': enable});

  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/profile',
      options: Options(
        method: 'PATCH',
        headers: headers,
      ),
      data: data,
    );
    print(response.data['face_id']);
    // emit(Changefacestate());
  } on DioException catch (e) {
    print(e.response);
    //  emit(Failedfacestate());
  }
}

patchcur(String currency) async {
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var data = FormData.fromMap({'currency': currency});

  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/profile',
      options: Options(
        method: 'PATCH',
        headers: headers,
      ),
      data: data,
    );
    print(response.data['currency']);
  } on DioException catch (e) {
    print(e.response);
  }
}
