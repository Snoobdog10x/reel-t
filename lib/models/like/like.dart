// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';




class Like extends AbstractModel {
  String userId = "";
	String videoId = "";
	bool isLike = false;
	bool isDeleted = false;

  Like({
    String? id,
		String? userId,
		String? videoId,
		bool? isLike,
		bool? isDeleted,
  }){
    PATH = (Like).toString();
    if(id != null) this.id = id;
		if(userId != null) this.userId = userId;
		if(videoId != null) this.videoId = videoId;
		if(isLike != null) this.isLike = isLike;
		if(isDeleted != null) this.isDeleted = isDeleted;
  }

  Like.fromJson(Map<dynamic, dynamic> jsonMap) {
    PATH = (Like).toString();
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["videoId"] != null) videoId = jsonMap["videoId"];
		if(jsonMap["isLike"] != null) isLike = jsonMap["isLike"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
  }

  Like.fromStringJson(String stringJson) {
    PATH = (Like).toString();
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["videoId"] != null) videoId = jsonMap["videoId"];
		if(jsonMap["isLike"] != null) isLike = jsonMap["isLike"];
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
		jsonMap["isLike"] = isLike;
		jsonMap["isDeleted"] = isDeleted;
    return jsonMap;
  }
}
