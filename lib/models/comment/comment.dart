import 'dart:convert';
import '../../generated/abstract_model.dart';



class Comment extends AbstractModel{
  late String id;
	static String PATH = "Comments";

  Comment({
    String? id,
  }){
    this.id = id ?? "";
  }

  Comment.fromJson(Map<dynamic, dynamic> jsonMap) {
    id = jsonMap["id"] ?? "";
  }

  Comment.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    id = jsonMap["id"] ?? "";
  }

  String toStringJson() {
    return json.encode(this.toJson());
  }

  String toString() {
    return toStringJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    return data;
  }
}
