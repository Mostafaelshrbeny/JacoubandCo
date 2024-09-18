import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/models/cashmodel.dart';
import 'package:dio/dio.dart';

getCash() async {
  List<CashModel> cash = [];
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/app-settings',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    for (var element in response.data) {
      cash.add(CashModel.fromJson(element));
    }
    return cash;
  } on DioException catch (e) {
    print(e.response);
  }
}
