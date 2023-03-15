
import 'dart:convert';
import '../../models/like/like.dart';
enum PublicMode { PUBLIC,PRIVATE }

class Video {
  late String id;
	late String videoUrl;
	late String songName;
	late String creatorId;
	late int publicMode;
	late int comments;
	late int likes;
	late int views;
	late bool isDeleted;
	late List<Like> userLikes;

  Video({
    this.id = "",
		this.videoUrl = "",
		this.songName = "",
		this.creatorId = "",
		this.publicMode = 0,
		this.comments = 0,
		this.likes = 0,
		this.views = 0,
		this.isDeleted = false,
		this.userLikes = const [],
  });

  Video.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"] ?? "";
		videoUrl = json["videoUrl"] ?? "";
		songName = json["songName"] ?? "";
		creatorId = json["creatorId"] ?? "";
		publicMode = json["publicMode"] ?? 0;
		comments = json["comments"] ?? 0;
		likes = json["likes"] ?? 0;
		views = json["views"] ?? 0;
		isDeleted = json["isDeleted"] ?? false;
		userLikes = json["userLikes"] ?? const [];
  }

  Video.fromStringJson(String stringJson) {
    Map valueMap = json.decode(stringJson);
    Video.fromJson(valueMap);
  }

  String toStringJson() {
    return json.encode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
		data["videoUrl"] = this.videoUrl;
		data["songName"] = this.songName;
		data["creatorId"] = this.creatorId;
		data["publicMode"] = this.publicMode;
		data["comments"] = this.comments;
		data["likes"] = this.likes;
		data["views"] = this.views;
		data["isDeleted"] = this.isDeleted;
		data["userLikes"] = this.userLikes;
    return data;
  }
}