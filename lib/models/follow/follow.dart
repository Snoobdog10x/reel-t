import 'dart:convert';
import '../../generated/abstract_model.dart';

enum FollowType { UNFOLLOW,FOLLOW }

class Follow extends AbstractModel{
  late String id;
	late String userId;
	late String followerId;
	late int followType;
	late bool isDeleted;
	static String PATH = "Follows";

  Follow({
    String? id,
		String? userId,
		String? followerId,
		int? followType,
		bool? isDeleted,
  }){
    this.id = id ?? "";
		this.userId = userId ?? "";
		this.followerId = followerId ?? "";
		this.followType = followType ?? 0;
		this.isDeleted = isDeleted ?? false;
  }

  Follow.fromJson(Map<dynamic, dynamic> jsonMap) {
    id = jsonMap["id"] ?? "";
		userId = jsonMap["userId"] ?? "";
		followerId = jsonMap["followerId"] ?? "";
		followType = jsonMap["followType"] ?? 0;
		isDeleted = jsonMap["isDeleted"] ?? false;
  }

  Follow.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    id = jsonMap["id"] ?? "";
		userId = jsonMap["userId"] ?? "";
		followerId = jsonMap["followerId"] ?? "";
		followType = jsonMap["followType"] ?? 0;
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
		data["followerId"] = this.followerId;
		data["followType"] = this.followType;
		data["isDeleted"] = this.isDeleted;
    return data;
  }
}
