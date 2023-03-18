
import 'dart:convert';

enum LikeType { UNLIKE,LIKE }

class Like {
  late String id;
	late String userId;
	late int likeType;

  Like({
    String? id,
		String? userId,
		int? likeType,
  }){
    this.id = id ?? "";
		this.userId = userId ?? "";
		this.likeType = likeType ?? 0;
  }

  Like.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
		userId = json["userId"];
		likeType = json["likeType"];
  }

  Like.fromStringJson(String stringJson) {
    Map valueMap = json.decode(stringJson);
    Like.fromJson(valueMap);
  }

  String toStringJson() {
    return json.encode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
		data["userId"] = this.userId;
		data["likeType"] = this.likeType;
    return data;
  }
}