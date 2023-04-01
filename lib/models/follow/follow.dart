// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';




class Follow extends AbstractModel {
  String userId = "";
	String followerId = "";
	bool isFollow = false;
	bool isDeleted = false;

  Follow({
    String? id,
		String? userId,
		String? followerId,
		bool? isFollow,
		bool? isDeleted,
  }){
    if(id != null) this.id = id;
		if(userId != null) this.userId = userId;
		if(followerId != null) this.followerId = followerId;
		if(isFollow != null) this.isFollow = isFollow;
		if(isDeleted != null) this.isDeleted = isDeleted;
  }

  Follow.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["followerId"] != null) followerId = jsonMap["followerId"];
		if(jsonMap["isFollow"] != null) isFollow = jsonMap["isFollow"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
  }

  Follow.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["followerId"] != null) followerId = jsonMap["followerId"];
		if(jsonMap["isFollow"] != null) isFollow = jsonMap["isFollow"];
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
		jsonMap["isFollow"] = isFollow;
		jsonMap["isDeleted"] = isDeleted;
    return jsonMap;
  }
}
