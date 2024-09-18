import 'package:bloc/bloc.dart';
import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/cubits/UsersCubit/users_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(InitiialState());
  static UsersCubit get(context) => BlocProvider.of(context);

  createUser(
      {required String email,
      required String password,
      required String name,
      required XFile? image}) async {
    emit(LoadCUserState());
    final String newPath = image == null ? '' : image.path.split('/').last;

    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var data = FormData.fromMap({
      'email': email,
      'password': password,
      'name': name,
      'active': true,
      'image': image == null
          ? null
          : await MultipartFile.fromFile(image.path,
              filename: newPath, contentType: MediaType('image', 'jpg'))
    });

    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/users',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);
      emit(CreatedUserState());
    } on DioException catch (e) {
      print(e.response);
      emit(FailedCUserState());
    }
  }
}
