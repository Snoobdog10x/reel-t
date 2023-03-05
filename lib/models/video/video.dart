
import 'dart:convert';

enum PublicMode { PUBLIC,PRIVATE }

class Video {
  String? id;
	String? videoUrl;
	String? songName;
	String? creatorId;
	int? publicMode;
	int? comments;
	int? likes;
	int? views;
	bool? isDeleted;

  Video({
    this.id,
		this.videoUrl,
		this.songName,
		this.creatorId,
		this.publicMode,
		this.comments,
		this.likes,
		this.views,
		this.isDeleted,
  });

  Video.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
		videoUrl = json["videoUrl"];
		songName = json["songName"];
		creatorId = json["creatorId"];
		publicMode = json["publicMode"];
		comments = json["comments"];
		likes = json["likes"];
		views = json["views"];
		isDeleted = json["isDeleted"];
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
    return data;
  }
}