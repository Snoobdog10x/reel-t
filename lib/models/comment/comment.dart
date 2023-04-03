// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';
import '../../models/user_profile/user_profile.dart';



class Comment{
  String id = "";
	String content = "";
	String userId = "";
	List<UserProfile> user = [];
	int subCommentsNum = 0;
	List<Comment> subComments = [];
	int createAt = 0;
	static String PATH = "Comments";

  Comment({
    String? id,
		String? content,
		String? userId,
		List<UserProfile>? user,
		int? subCommentsNum,
		List<Comment>? subComments,
		int? createAt,
  }){
    if(id != null) this.id = id;
		if(content != null) this.content = content;
		if(userId != null) this.userId = userId;
		if(user != null) this.user = user;
		if(subCommentsNum != null) this.subCommentsNum = subCommentsNum;
		if(subComments != null) this.subComments = subComments;
		if(createAt != null) this.createAt = createAt;
  }

  Comment.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["content"] != null) content = jsonMap["content"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["subCommentsNum"] != null) subCommentsNum = jsonMap["subCommentsNum"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
  }

  Comment.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["content"] != null) content = jsonMap["content"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["subCommentsNum"] != null) subCommentsNum = jsonMap["subCommentsNum"];
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
		jsonMap["content"] = content;
		jsonMap["userId"] = userId;
		jsonMap["subCommentsNum"] = subCommentsNum;
		jsonMap["createAt"] = createAt;
    return jsonMap;
  }
}
