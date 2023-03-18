
import 'dart:convert';

enum LikeType { UNLIKE,LIKE }

class Like {
  late String id;
	late String userId;
	late String videoId;
	late int likeType;

  Like({
    String? id,
		String? userId,
		String? videoId,
		int? likeType,
  }){
    this.id = id ?? "";
		this.userId = userId ?? "";
		this.videoId = videoId ?? "";
		this.likeType = likeType ?? 0;
  }

  Like.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
		userId = json["userId"];
		videoId = json["videoId"];
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
		data["videoId"] = this.videoId;
		data["likeType"] = this.likeType;
    return data;
  }
}