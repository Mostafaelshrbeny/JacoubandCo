import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';
//import 'dart:ui' as ui;

import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';
import 'package:dio/dio.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:meta/meta.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsInitial());
  static CommentsCubit get(context) => BlocProvider.of(context);
  bool emojivis = true;
  closekey(BuildContext cxt) {
    FocusManager.instance.primaryFocus?.unfocus();

    emit(Closestate());
  }

  emojifun() {
    emojivis = !emojivis;
    emit(Emojistate());
  }

  Future takeimage() async {
    final pickedimage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);

    img = pickedimage;
    final image = await MultipartFile.fromFile(pickedimage!.path,
        filename: pickedimage.path.split('/').last,
        contentType: MediaType('image', 'jpg'));
    final bytes = (await img!.readAsBytes()).lengthInBytes;

    print(bytes);

    return image;
  }

  Future pickfile() async {
    final doc = await FilePicker.platform.pickFiles();
    return doc!.files.first.path;
  }

  Future pickimageChat() async {
    final pickedimage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);
    img = pickedimage;
    // final image = await MultipartFile.fromFile(pickedimage!.path,
    //     filename: pickedimage.path.split('/').last,
    //     contentType: MediaType('image', 'jpg'));

    return img;
  }

  Future bufferimage() async {
    final pickedimage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);

    img = pickedimage;
    if (pickedimage == null) return null;
    base64Image = await pickedimage.readAsBytes();
    // Uint8List data = await pickedimage.readAsBytes();
    // if (data.isEmpty) return null;
    // ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    // ui.FrameInfo frameInfo = await codec.getNextFrame();
    // ui.Image im = frameInfo.image;
    // base64Image = await im.toByteData(format: ui.ImageByteFormat.png);

    return img;
  }

  createPostComment(
      {required int groupid,
      required int postid,
      required String comment}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginbox!.get('token')}'
    };
    var data = json.encode({"comment": comment});
    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/groups/$groupid/posts/$postid/comments',
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

  createNewPost(
      {required XFile? image,
      required File? doc,
      required String? body,
      required List<String> tags,
      required int id}) async {
    emit(PostLoadingstate());
    final String newImagePath = image == null ? '' : image.path.split('/').last;
    final String newDocPath = doc == null ? '' : doc.path.split('/').last;
    var headers = {'Authorization': 'Bearer ${loginbox!.get('token')}'};
    var data = FormData.fromMap({
      'attachments': image == null && doc == null
          ? []
          : doc == null
              ? [
                  await MultipartFile.fromFile(image!.path,
                      filename: newImagePath,
                      contentType: MediaType('image', 'jpg'))
                ]
              : [
                  await MultipartFile.fromFile(doc.path,
                      filename: newDocPath,
                      contentType: MediaType('application', 'pdf')),
                ],
      'body': body,
      'tags[]': tags
    });

    var dio = Dio();
    try {
      var response = await dio.request(
        '${Constant.url}/groups/$id/posts',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      emit(PostDonestate());
    } on DioException catch (e) {
      print(e.response);
      emit(PostFailedstate());
    }
  }

  uploadimage({required ImageSource source}) async {
    final pickedimage =
        await ImagePicker().pickImage(source: source, imageQuality: 25);
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
      img = pickedimage;
      print(response.data[0]);
      imageToUpload = response.data[0];
    } on DioException catch (e) {
      print(e.response);
    }
  }
}

XFile? img;
String? imageToUpload;
// Convert bytes to base64 string
Uint8List? base64Image;
