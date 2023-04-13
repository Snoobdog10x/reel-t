// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';
import '../../models/comment/comment.dart';
enum PublicMode { PUBLIC,PRIVATE }


class Video{
  static const String id_PATH = "id";
	String id = "";
	static const String videoUrl_PATH = "videoUrl";
	String videoUrl = "";
	static const String videoThumbnail_PATH = "videoThumbnail";
	String videoThumbnail = "";
	static const String songName_PATH = "songName";
	String songName = "";
	static const String creatorId_PATH = "creatorId";
	String creatorId = "";
	static const String title_PATH = "title";
	String title = "";
	static const String publicMode_PATH = "publicMode";
	int publicMode = 0;
	static const String commentsNum_PATH = "commentsNum";
	int commentsNum = 0;
	static const String likesNum_PATH = "likesNum";
	int likesNum = 0;
	static const String viewsNum_PATH = "viewsNum";
	int viewsNum = 0;
	static const String isDeleted_PATH = "isDeleted";
	bool isDeleted = false;
	static const String comment_PATH = "comment";
	List<Comment> comment = [];
	static const String createAt_PATH = "createAt";
	int createAt = 0;
	static const String PATH = "Videos";

  Video({
    String? id,
		String? videoUrl,
		String? videoThumbnail,
		String? songName,
		String? creatorId,
		String? title,
		int? publicMode,
		int? commentsNum,
		int? likesNum,
		int? viewsNum,
		bool? isDeleted,
		List<Comment>? comment,
		int? createAt,
  }){
    if(id != null) this.id = id;
		if(videoUrl != null) this.videoUrl = videoUrl;
		if(videoThumbnail != null) this.videoThumbnail = videoThumbnail;
		if(songName != null) this.songName = songName;
		if(creatorId != null) this.creatorId = creatorId;
		if(title != null) this.title = title;
		if(publicMode != null) this.publicMode = publicMode;
		if(commentsNum != null) this.commentsNum = commentsNum;
		if(likesNum != null) this.likesNum = likesNum;
		if(viewsNum != null) this.viewsNum = viewsNum;
		if(isDeleted != null) this.isDeleted = isDeleted;
		if(comment != null) this.comment = comment;
		if(createAt != null) this.createAt = createAt;
  }

  Video.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["videoUrl"] != null) videoUrl = jsonMap["videoUrl"];
		if(jsonMap["videoThumbnail"] != null) videoThumbnail = jsonMap["videoThumbnail"];
		if(jsonMap["songName"] != null) songName = jsonMap["songName"];
		if(jsonMap["creatorId"] != null) creatorId = jsonMap["creatorId"];
		if(jsonMap["title"] != null) title = jsonMap["title"];
		if(jsonMap["publicMode"] != null) publicMode = jsonMap["publicMode"];
		if(jsonMap["commentsNum"] != null) commentsNum = jsonMap["commentsNum"];
		if(jsonMap["likesNum"] != null) likesNum = jsonMap["likesNum"];
		if(jsonMap["viewsNum"] != null) viewsNum = jsonMap["viewsNum"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
  }

  Video.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["videoUrl"] != null) videoUrl = jsonMap["videoUrl"];
		if(jsonMap["videoThumbnail"] != null) videoThumbnail = jsonMap["videoThumbnail"];
		if(jsonMap["songName"] != null) songName = jsonMap["songName"];
		if(jsonMap["creatorId"] != null) creatorId = jsonMap["creatorId"];
		if(jsonMap["title"] != null) title = jsonMap["title"];
		if(jsonMap["publicMode"] != null) publicMode = jsonMap["publicMode"];
		if(jsonMap["commentsNum"] != null) commentsNum = jsonMap["commentsNum"];
		if(jsonMap["likesNum"] != null) likesNum = jsonMap["likesNum"];
		if(jsonMap["viewsNum"] != null) viewsNum = jsonMap["viewsNum"];
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
		jsonMap["videoUrl"] = videoUrl;
		jsonMap["videoThumbnail"] = videoThumbnail;
		jsonMap["songName"] = songName;
		jsonMap["creatorId"] = creatorId;
		jsonMap["title"] = title;
		jsonMap["publicMode"] = publicMode;
		jsonMap["commentsNum"] = commentsNum;
		jsonMap["likesNum"] = likesNum;
		jsonMap["viewsNum"] = viewsNum;
		jsonMap["isDeleted"] = isDeleted;
		jsonMap["createAt"] = createAt;
    return jsonMap;
  }

  @override
  bool operator ==(Object other) =>
      other is Video && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
