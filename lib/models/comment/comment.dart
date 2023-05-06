// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';




class Comment{
  static const String id_PATH = "id";
	String id = "";
	static const String videoId_PATH = "videoId";
	String videoId = "";
	static const String content_PATH = "content";
	String content = "";
	static const String userId_PATH = "userId";
	String userId = "";
	static const String parentCommentId_PATH = "parentCommentId";
	String parentCommentId = "";
	static const String subCommentsNum_PATH = "subCommentsNum";
	int subCommentsNum = 0;
	static const String subComments_PATH = "subComments";
	List<Comment> subComments = [];
	static const String numLikes_PATH = "numLikes";
	int numLikes = 0;
	static const String createAt_PATH = "createAt";
	int createAt = 0;
	static const String PATH = "Comments";

  Comment({
    String? id,
		String? videoId,
		String? content,
		String? userId,
		String? parentCommentId,
		int? subCommentsNum,
		List<Comment>? subComments,
		int? numLikes,
		int? createAt,
  }){
    if(id != null) this.id = id;
		if(videoId != null) this.videoId = videoId;
		if(content != null) this.content = content;
		if(userId != null) this.userId = userId;
		if(parentCommentId != null) this.parentCommentId = parentCommentId;
		if(subCommentsNum != null) this.subCommentsNum = subCommentsNum;
		if(subComments != null) this.subComments = subComments;
		if(numLikes != null) this.numLikes = numLikes;
		if(createAt != null) this.createAt = createAt;
  }

  Comment.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["videoId"] != null) videoId = jsonMap["videoId"];
		if(jsonMap["content"] != null) content = jsonMap["content"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["parentCommentId"] != null) parentCommentId = jsonMap["parentCommentId"];
		if(jsonMap["subCommentsNum"] != null) subCommentsNum = jsonMap["subCommentsNum"];
		if(jsonMap["numLikes"] != null) numLikes = jsonMap["numLikes"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
  }

  Comment.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["videoId"] != null) videoId = jsonMap["videoId"];
		if(jsonMap["content"] != null) content = jsonMap["content"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["parentCommentId"] != null) parentCommentId = jsonMap["parentCommentId"];
		if(jsonMap["subCommentsNum"] != null) subCommentsNum = jsonMap["subCommentsNum"];
		if(jsonMap["numLikes"] != null) numLikes = jsonMap["numLikes"];
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
		jsonMap["videoId"] = videoId;
		jsonMap["content"] = content;
		jsonMap["userId"] = userId;
		jsonMap["parentCommentId"] = parentCommentId;
		jsonMap["subCommentsNum"] = subCommentsNum;
		jsonMap["numLikes"] = numLikes;
		jsonMap["createAt"] = createAt;
    return jsonMap;
  }

  @override
  bool operator ==(Object other) =>
      other is Comment && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
