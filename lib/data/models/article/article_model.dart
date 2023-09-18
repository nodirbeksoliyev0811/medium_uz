import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ArticleModel {
  final int artId;
  final String image;
  final String title;
  final String description;
  final String likes;
  final String views;
  final String addDate;
  final String username;
  final String avatar;
  final String profession;
  final int userId;
  final String hashtag;

  ArticleModel({
    required this.profession,
    required this.userId,
    required this.likes,
    required this.artId,
    required this.image,
    required this.description,
    required this.views,
    required this.title,
    required this.avatar,
    required this.addDate,
    required this.username,
    required this.hashtag,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      userId: json["user_id"] as int? ?? 0,
      profession: json["profession"] as String? ?? "",
      likes: json["likes"] as String? ?? "",
      artId: json["art_id"] as int? ?? 0,
      image: json["image"] as String? ?? "",
      description: json["description"] as String? ?? "",
      views: json["views"] as String? ?? "",
      title: json["title"] as String? ?? "",
      avatar: json["avatar"] as String? ?? "",
      addDate: json["add_date"] as String? ?? "",
      username: json["username"] as String? ?? "",
      hashtag: json["hashtag"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "profession": profession,
      "userId": userId,
      "title": title,
      "description": description,
      "likes": likes,
      "views": views,
      "addDate": addDate,
      "username": username,
      "avatar": avatar,
    };
  }
  Future<FormData> getFormData() async {
    XFile file = XFile(image);
    String fileName = file.path.split('/').last;
    return FormData.fromMap({
      "hashtag":hashtag,
      "title":title,
      "description":description,
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });
  }
}