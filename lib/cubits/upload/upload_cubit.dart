import 'package:bloc/bloc.dart';
import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/upload/upload_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(InitialState());
  static UploadCubit get(context) => BlocProvider.of(context);
  uploadimage() async {
    final pickedimage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);
    final String newPath = pickedimage!.path.split('/').last;
    try {
      var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
      var data = FormData.fromMap({
        'attachments': await MultipartFile.fromFile(pickedimage.path,
            filename: newPath, contentType: MediaType('image', 'jpg')),
      });

      var dio = Dio();
      var response = await dio.request(
        '${Constant.url}/uploads',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
    } on DioException catch (e) {
      print(e.response);
    }
  }
}
