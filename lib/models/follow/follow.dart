
import 'dart:convert';

enum FollowType { UNFOLLOW,FOLLOW }

class Follow {
  late String id;
	late String userId;
	late String followerId;
	late int followType;

  Follow({
    String? id,
		String? userId,
		String? followerId,
		int? followType,
  }){
    this.id = id ?? "";
		this.userId = userId ?? "";
		this.followerId = followerId ?? "";
		this.followType = followType ?? 0;
  }

  Follow.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
		userId = json["userId"];
		followerId = json["followerId"];
		followType = json["followType"];
  }

  Follow.fromStringJson(String stringJson) {
    Map valueMap = json.decode(stringJson);
    Follow.fromJson(valueMap);
  }

  String toStringJson() {
    return json.encode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
		data["userId"] = this.userId;
		data["followerId"] = this.followerId;
		data["followType"] = this.followType;
    return data;
  }
}