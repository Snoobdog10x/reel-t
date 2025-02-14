// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';




class Follow{
  static const String id_PATH = "id";
	String id = "";
	static const String userId_PATH = "userId";
	String userId = "";
	static const String followerId_PATH = "followerId";
	String followerId = "";
	static const String isFollow_PATH = "isFollow";
	bool isFollow = false;
	static const String isDeleted_PATH = "isDeleted";
	bool isDeleted = false;
	static const String createAt_PATH = "createAt";
	int createAt = 0;
	static const String PATH = "Follows";

  Follow({
    String? id,
		String? userId,
		String? followerId,
		bool? isFollow,
		bool? isDeleted,
		int? createAt,
  }){
    if(id != null) this.id = id;
		if(userId != null) this.userId = userId;
		if(followerId != null) this.followerId = followerId;
		if(isFollow != null) this.isFollow = isFollow;
		if(isDeleted != null) this.isDeleted = isDeleted;
		if(createAt != null) this.createAt = createAt;
  }

  Follow.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["followerId"] != null) followerId = jsonMap["followerId"];
		if(jsonMap["isFollow"] != null) isFollow = jsonMap["isFollow"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
  }

  Follow.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["followerId"] != null) followerId = jsonMap["followerId"];
		if(jsonMap["isFollow"] != null) isFollow = jsonMap["isFollow"];
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
		jsonMap["followerId"] = followerId;
		jsonMap["isFollow"] = isFollow;
		jsonMap["isDeleted"] = isDeleted;
		jsonMap["createAt"] = createAt;
    return jsonMap;
  }

  @override
  bool operator ==(Object other) =>
      other is Follow && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
