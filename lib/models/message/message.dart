import 'dart:convert';



class Message {
  late String id;
	late String userId;
	late String content;
	late bool isDeleted;

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

  Message.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
		userId = json["userId"];
		content = json["content"];
		isDeleted = json["isDeleted"];
  }

  Message.fromStringJson(String stringJson) {
    Map valueMap = json.decode(stringJson);
    Message.fromJson(valueMap);
  }

  String toStringJson() {
    return json.encode(this.toJson());
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
