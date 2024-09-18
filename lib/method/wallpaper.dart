import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:chatjob/models/wallpaper_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

getWallpapers() async {
  List<WallpaperModel> wallpaperlist;
  try {
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var dio = Dio();
    var response = await dio.request(
      '${Constant.url}/wallpapers',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    wallpaperlist = await (response.data)
        .map<WallpaperModel>((x) => WallpaperModel.fromJson(x))
        .toList() as List<WallpaperModel>;
    return wallpaperlist;
  } on DioException catch (e) {
    print(e.response);
  }
}

addWallpaper({required XFile image}) async {
  final String newPath = image.path.split('/').last;
  try {
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var data = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path,
          filename: newPath, contentType: MediaType('image', 'jpg')),
    });

    var dio = Dio();
    var response = await dio.request(
      '${Constant.url}/wallpapers',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    print(response.data);
  } on DioException catch (e) {
    print(e.response);
  }
}

deleteWallpaper({required int id}) async {
  try {
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var dio = Dio();
    var response = await dio.request(
      '${Constant.url}/wallpapers/$id',
      options: Options(
        method: 'DELETE',
        headers: headers,
      ),
    );
    print(response.data);
  } on DioException catch (e) {
    print(e.response);
  }
}

getAvailable() async {
  List<WallpaperModel> wallpaperlist;
  var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
  var dio = Dio();
  try {
    var response = await dio.request(
      '${Constant.url}/wallpapers/available',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    wallpaperlist = await (response.data)
        .map<WallpaperModel>((x) => WallpaperModel.fromJson(x))
        .toList() as List<WallpaperModel>;
    return wallpaperlist;
  } on DioException catch (e) {
    print(e.response);
  }
}
