
import 'dart:convert';



class Comment {
  late String id;

  Comment({
    String? id,
  }){
    this.id = id ?? "";
  }

  Comment.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
  }

  Comment.fromStringJson(String stringJson) {
    Map valueMap = json.decode(stringJson);
    Comment.fromJson(valueMap);
  }

  String toStringJson() {
    return json.encode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    return data;
  }
}