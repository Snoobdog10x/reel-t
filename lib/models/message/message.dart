// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';




class Message{
  static const String id_PATH = "id";
	String id = "";
	static const String userId_PATH = "userId";
	String userId = "";
	static const String content_PATH = "content";
	String content = "";
	static const String hasSeen_PATH = "hasSeen";
	bool hasSeen = false;
	static const String isDeleted_PATH = "isDeleted";
	bool isDeleted = false;
	static const String createAt_PATH = "createAt";
	int createAt = 0;
	static const String PATH = "Messages";

  Message({
    String? id,
		String? userId,
		String? content,
		bool? hasSeen,
		bool? isDeleted,
		int? createAt,
  }){
    if(id != null) this.id = id;
		if(userId != null) this.userId = userId;
		if(content != null) this.content = content;
		if(hasSeen != null) this.hasSeen = hasSeen;
		if(isDeleted != null) this.isDeleted = isDeleted;
		if(createAt != null) this.createAt = createAt;
  }

  Message.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["content"] != null) content = jsonMap["content"];
		if(jsonMap["hasSeen"] != null) hasSeen = jsonMap["hasSeen"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
  }

  Message.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["content"] != null) content = jsonMap["content"];
		if(jsonMap["hasSeen"] != null) hasSeen = jsonMap["hasSeen"];
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
		jsonMap["userId"] = userId;
		jsonMap["content"] = content;
		jsonMap["hasSeen"] = hasSeen;
		jsonMap["isDeleted"] = isDeleted;
		jsonMap["createAt"] = createAt;
    return jsonMap;
  }

  @override
  bool operator ==(Object other) =>
      other is Message && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
