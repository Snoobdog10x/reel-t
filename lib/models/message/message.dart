// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';
import 'package:hive/hive.dart';
part 'message.g.dart';


@HiveType(typeId: 2)
class Message extends AbstractModel  with HiveObjectMixin{
  @HiveField(0) 
	String userId = "";
	@HiveField(1) 
	String content = "";
	@HiveField(2) 
	bool isDeleted = false;

  Message({
    String? id,
		String? userId,
		String? content,
		bool? isDeleted,
  }){
    if(id != null) this.id = id;
		if(userId != null) this.userId = userId;
		if(content != null) this.content = content;
		if(isDeleted != null) this.isDeleted = isDeleted;
  }

  Message.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["content"] != null) content = jsonMap["content"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
  }

  Message.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["content"] != null) content = jsonMap["content"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
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
		jsonMap["isDeleted"] = isDeleted;
    return jsonMap;
  }
}
