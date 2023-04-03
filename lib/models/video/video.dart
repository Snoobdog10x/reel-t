// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';
import '../../models/user_profile/user_profile.dart';
import '../../models/like/like.dart';
import '../../models/follow/follow.dart';
import '../../models/comment/comment.dart';
enum PublicMode { PUBLIC,PRIVATE }


class Video{
  String id = "";
	String videoUrl = "";
	String songName = "";
	String creatorId = "";
	String title = "";
	int publicMode = 0;
	int commentsNum = 0;
	int likesNum = 0;
	int viewsNum = 0;
	bool isDeleted = false;
	List<Like> like = [];
	List<Follow> followCreator = [];
	List<Comment> comment = [];
	List<UserProfile> creator = [];
	int createAt = 0;
	static String PATH = "Videos";

  Video({
    String? id,
		String? videoUrl,
		String? songName,
		String? creatorId,
		String? title,
		int? publicMode,
		int? commentsNum,
		int? likesNum,
		int? viewsNum,
		bool? isDeleted,
		List<Like>? like,
		List<Follow>? followCreator,
		List<Comment>? comment,
		List<UserProfile>? creator,
		int? createAt,
  }){
    if(id != null) this.id = id;
		if(videoUrl != null) this.videoUrl = videoUrl;
		if(songName != null) this.songName = songName;
		if(creatorId != null) this.creatorId = creatorId;
		if(title != null) this.title = title;
		if(publicMode != null) this.publicMode = publicMode;
		if(commentsNum != null) this.commentsNum = commentsNum;
		if(likesNum != null) this.likesNum = likesNum;
		if(viewsNum != null) this.viewsNum = viewsNum;
		if(isDeleted != null) this.isDeleted = isDeleted;
		if(like != null) this.like = like;
		if(followCreator != null) this.followCreator = followCreator;
		if(comment != null) this.comment = comment;
		if(creator != null) this.creator = creator;
		if(createAt != null) this.createAt = createAt;
  }

  Video.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["videoUrl"] != null) videoUrl = jsonMap["videoUrl"];
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
}
