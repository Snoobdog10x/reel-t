import 'dart:convert';
import '../../generated/abstract_model.dart';




class Comment{
  String id = "";
	static String PATH = "Comments";

  Comment({
    String? id,
  }){
    if(id != null) this.id = id;
  }

  Comment.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
  }

  Comment.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
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
    return jsonMap;
  }
}
