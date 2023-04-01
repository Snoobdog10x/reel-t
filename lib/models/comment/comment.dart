// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';




class Comment extends AbstractModel {
  String content = "";

  Comment({
    String? id,
		String? content,
  }){
    PATH = (Comment).toString();
    if(id != null) this.id = id;
		if(content != null) this.content = content;
  }

  Comment.fromJson(Map<dynamic, dynamic> jsonMap) {
    PATH = (Comment).toString();
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["content"] != null) content = jsonMap["content"];
  }

  Comment.fromStringJson(String stringJson) {
    PATH = (Comment).toString();
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["content"] != null) content = jsonMap["content"];
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
    return jsonMap;
  }
}
