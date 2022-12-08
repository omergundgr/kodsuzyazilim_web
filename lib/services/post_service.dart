import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:kodulartools/constants.dart';
import 'package:kodulartools/controllers/MenuController.dart';
import 'package:kodulartools/models/post_model.dart';

class PublishService {
  final String title;
  final String post;
  List<String> categories;
  final String userMail;
  final String postType;

  final _dio = dio.Dio();

  PublishService(
      {required this.title,
      required this.post,
      this.categories = const [],
      required this.userMail,
      required this.postType});

  Future postBlog() async {
    String type = postType == "Eklenti Paylaş"
        ? "extension"
        : postType == "Şema Paylaş"
            ? "schema"
            : "blog";
    if (type == "extension") categories = ["Eklenti Dökümantasyon, extension"];
    if (postType != "Blog Yaz") categories = [type];
    final response = await _dio.post(
        "$kHostAdress/post?userMail=$userMail&body=$post&title=$title&categories=${categories.join(",")}&type=$type");
  }
}

class UploadService {
  final _dio = dio.Dio();

  Future uploadFile({required Function event}) async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["aix", "ais", "aia", "json"]);
    if (result == null) {
      event(null);
    } else {
      final fileAsBytes = result.files.first.bytes;

      final formData = dio.FormData.fromMap({
        "file": dio.MultipartFile.fromBytes(result.files.first.bytes!,
            filename: result.files.first.name)
      });
      final response =
          await _dio.post("$kHostAdress/uploadFile", data: formData);
      if (response.statusCode == 200) {
        event(response.data);
      } else {
        event(null);
      }
    }
  }

  Future uploadImage({required Function event}) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) {
      event(null);
    } else {
      final formData = dio.FormData.fromMap({
        "image": dio.MultipartFile.fromBytes(result.files.first.bytes!,
            filename: result.files.first.name)
      });
      final response =
          await _dio.post("$kHostAdress/uploadImage", data: formData);
      if (response.statusCode == 200) {
        event(response.data);
      } else {
        event(null);
      }
    }
  }
}

class GetterService {
  final _dio = dio.Dio();
  final MenuController _menuCtrl = Get.find();

  Future getPosts({String? category}) async {
    _menuCtrl.setPostOffset(0);
    _menuCtrl.clearPostList();
    _menuCtrl.setPostLoading(true);
    _menuCtrl.setNoResult(false);
    final result = await _dio.get(
        "$kHostAdress/getPosts/5/${_menuCtrl.postOffset}${category != null ? "?category=$category" : ""}");
    if (result.data != "ERROR") {
      final list = result.data as List;
      final List<Post> postList = list.map((e) => Post.fromJson(e)).toList();
      _menuCtrl.addToPostList(postList);
      _menuCtrl.setPostOffset(_menuCtrl.postOffset + 5);
    } else {
      _menuCtrl.setNoResult(true);
    }
    _menuCtrl.setPostLoading(false);
  }
}
