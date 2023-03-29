import 'dart:convert';
import '../../generated/abstract_model.dart';

enum LikeType { UNLIKE, LIKE }

class Like extends AbstractModel {
  late String id;
  late String userId;
  late String videoId;
  late int likeType;
  late bool isDeleted;
  static String PATH = "Likes";

  Like({
    String? id,
    String? userId,
    String? videoId,
    int? likeType,
    bool? isDeleted,
  }) {
    this.id = id ?? "";
    this.userId = userId ?? "";
    this.videoId = videoId ?? "";
    this.likeType = likeType ?? 0;
    this.isDeleted = isDeleted ?? false;
  }

  Like.fromJson(Map<dynamic, dynamic> jsonMap) {
    id = jsonMap["id"] ?? "";
    userId = jsonMap["userId"] ?? "";
    videoId = jsonMap["videoId"] ?? "";
    likeType = jsonMap["likeType"] ?? 0;
    isDeleted = jsonMap["isDeleted"] ?? false;
  }

  Like.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    id = jsonMap["id"] ?? "";
    userId = jsonMap["userId"] ?? "";
    videoId = jsonMap["videoId"] ?? "";
    likeType = jsonMap["likeType"] ?? 0;
    isDeleted = jsonMap["isDeleted"] ?? false;
  }

  String toStringJson() {
    return json.encode(this.toJson());
  }

  String toString() {
    return toStringJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["userId"] = this.userId;
    data["videoId"] = this.videoId;
    data["likeType"] = this.likeType;
    data["isDeleted"] = this.isDeleted;
    return data;
  }

  void likeVideo() {
    if (likeType == LikeType.LIKE) {
      likeType = LikeType.UNLIKE.index;
      return;
    }
    likeType = LikeType.LIKE.index;
    return;
  }
}
