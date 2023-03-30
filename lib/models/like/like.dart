// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';

enum LikeType { UNLIKE,LIKE }


class Like{
  String id = "";
	String userId = "";
	String videoId = "";
	int likeType = 0;
	bool isDeleted = false;
	static String PATH = "Likes";

  Like({
    String? id,
		String? userId,
		String? videoId,
		int? likeType,
		bool? isDeleted,
  }){
    if(id != null) this.id = id;
		if(userId != null) this.userId = userId;
		if(videoId != null) this.videoId = videoId;
		if(likeType != null) this.likeType = likeType;
		if(isDeleted != null) this.isDeleted = isDeleted;
  }

  Like.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["videoId"] != null) videoId = jsonMap["videoId"];
		if(jsonMap["likeType"] != null) likeType = jsonMap["likeType"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
  }

  Like.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["videoId"] != null) videoId = jsonMap["videoId"];
		if(jsonMap["likeType"] != null) likeType = jsonMap["likeType"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
  }

  String toStringJson() {
    return json.encode(this.toJson());
  }

  String toString() {
    return toStringJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap["id"] = id;
		jsonMap["userId"] = userId;
		jsonMap["videoId"] = videoId;
		jsonMap["likeType"] = likeType;
		jsonMap["isDeleted"] = isDeleted;
    return jsonMap;
  }
}
