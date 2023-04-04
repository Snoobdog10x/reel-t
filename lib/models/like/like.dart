// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';




class Like{
  static String id_PATH = "id";
	String id = "";
	static String userId_PATH = "userId";
	String userId = "";
	static String videoId_PATH = "videoId";
	String videoId = "";
	static String isLike_PATH = "isLike";
	bool isLike = false;
	static String isDeleted_PATH = "isDeleted";
	bool isDeleted = false;
	static String createAt_PATH = "createAt";
	int createAt = 0;
	static String PATH = "Likes";

  Like({
    String? id,
		String? userId,
		String? videoId,
		bool? isLike,
		bool? isDeleted,
		int? createAt,
  }){
    if(id != null) this.id = id;
		if(userId != null) this.userId = userId;
		if(videoId != null) this.videoId = videoId;
		if(isLike != null) this.isLike = isLike;
		if(isDeleted != null) this.isDeleted = isDeleted;
		if(createAt != null) this.createAt = createAt;
  }

  Like.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["videoId"] != null) videoId = jsonMap["videoId"];
		if(jsonMap["isLike"] != null) isLike = jsonMap["isLike"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
  }

  Like.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["videoId"] != null) videoId = jsonMap["videoId"];
		if(jsonMap["isLike"] != null) isLike = jsonMap["isLike"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
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
		jsonMap["isLike"] = isLike;
		jsonMap["isDeleted"] = isDeleted;
		jsonMap["createAt"] = createAt;
    return jsonMap;
  }
}
