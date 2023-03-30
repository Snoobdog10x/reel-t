import 'dart:convert';
import '../../generated/abstract_model.dart';

enum FollowType { UNFOLLOW,FOLLOW }


class Follow{
  String id = "";
	String userId = "";
	String followerId = "";
	int followType = 0;
	bool isDeleted = false;
	static String PATH = "Follows";

  Follow({
    String? id,
		String? userId,
		String? followerId,
		int? followType,
		bool? isDeleted,
  }){
    if(id != null) this.id = id;
		if(userId != null) this.userId = userId;
		if(followerId != null) this.followerId = followerId;
		if(followType != null) this.followType = followType;
		if(isDeleted != null) this.isDeleted = isDeleted;
  }

  Follow.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["followerId"] != null) followerId = jsonMap["followerId"];
		if(jsonMap["followType"] != null) followType = jsonMap["followType"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
  }

  Follow.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["followerId"] != null) followerId = jsonMap["followerId"];
		if(jsonMap["followType"] != null) followType = jsonMap["followType"];
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
		jsonMap["followerId"] = followerId;
		jsonMap["followType"] = followType;
		jsonMap["isDeleted"] = isDeleted;
    return jsonMap;
  }
}
