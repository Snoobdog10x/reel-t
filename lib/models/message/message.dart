import 'dart:convert';
import '../../generated/abstract_model.dart';



class Message extends AbstractModel{
  late String id;
	late String userId;
	late String content;
	late bool isDeleted;
	static String PATH = "Messages";

  Message({
    String? id,
		String? userId,
		String? content,
		bool? isDeleted,
  }){
    this.id = id ?? "";
		this.userId = userId ?? "";
		this.content = content ?? "";
		this.isDeleted = isDeleted ?? false;
  }

  Message.fromJson(Map<dynamic, dynamic> jsonMap) {
    id = jsonMap["id"] ?? "";
		userId = jsonMap["userId"] ?? "";
		content = jsonMap["content"] ?? "";
		isDeleted = jsonMap["isDeleted"] ?? false;
  }

  Message.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    id = jsonMap["id"] ?? "";
		userId = jsonMap["userId"] ?? "";
		content = jsonMap["content"] ?? "";
		isDeleted = jsonMap["isDeleted"] ?? false;
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
		data["userId"] = this.userId;
		data["content"] = this.content;
		data["isDeleted"] = this.isDeleted;
    return data;
  }
}
