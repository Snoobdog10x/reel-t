import 'dart:convert';



class Conversation {
  late String id;
	late String firstUserId;
	late String secondUserId;
	late bool isMute;
	late bool isDeleted;

  Conversation({
    String? id,
		String? firstUserId,
		String? secondUserId,
		bool? isMute,
		bool? isDeleted,
  }){
    this.id = id ?? "";
		this.firstUserId = firstUserId ?? "";
		this.secondUserId = secondUserId ?? "";
		this.isMute = isMute ?? false;
		this.isDeleted = isDeleted ?? false;
  }

  Conversation.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
		firstUserId = json["firstUserId"];
		secondUserId = json["secondUserId"];
		isMute = json["isMute"];
		isDeleted = json["isDeleted"];
  }

  Conversation.fromStringJson(String stringJson) {
    Map valueMap = json.decode(stringJson);
    Conversation.fromJson(valueMap);
  }

  String toStringJson() {
    return json.encode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
		data["firstUserId"] = this.firstUserId;
		data["secondUserId"] = this.secondUserId;
		data["isMute"] = this.isMute;
		data["isDeleted"] = this.isDeleted;
    return data;
  }
}
