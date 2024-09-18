import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/models/company_model.dart';
import 'package:dio/dio.dart';

getcompany(int id) async {
  CompanyModel? companyData;
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/companies/$id',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    companyData = CompanyModel.fromJson(response.data);
    return companyData;
  } on DioException catch (e) {
    print(e.response);
  }
}
