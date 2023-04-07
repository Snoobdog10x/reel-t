// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';
import '../../models/user_profile/user_profile.dart';



class Conversation{
  static const String id_PATH = "id";
	String id = "";
	static const String userIds_PATH = "userIds";
	List<String> userIds = [];
	static const String contactUser_PATH = "contactUser";
	List<UserProfile> contactUser = [];
	static const String latestMessage_PATH = "latestMessage";
	String latestMessage = "";
	static const String isMute_PATH = "isMute";
	bool isMute = false;
	static const String isDeleted_PATH = "isDeleted";
	bool isDeleted = false;
	static const String createAt_PATH = "createAt";
	int createAt = 0;
	static const String updateAt_PATH = "updateAt";
	int updateAt = 0;
	static const String PATH = "Conversations";

  Conversation({
    String? id,
		List<String>? userIds,
		List<UserProfile>? contactUser,
		String? latestMessage,
		bool? isMute,
		bool? isDeleted,
		int? createAt,
		int? updateAt,
  }){
    if(id != null) this.id = id;
		if(userIds != null) this.userIds = userIds;
		if(contactUser != null) this.contactUser = contactUser;
		if(latestMessage != null) this.latestMessage = latestMessage;
		if(isMute != null) this.isMute = isMute;
		if(isDeleted != null) this.isDeleted = isDeleted;
		if(createAt != null) this.createAt = createAt;
		if(updateAt != null) this.updateAt = updateAt;
  }

  Conversation.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userIds"] != null) userIds = jsonMap["userIds"].cast<String>();
		if(jsonMap["latestMessage"] != null) latestMessage = jsonMap["latestMessage"];
		if(jsonMap["isMute"] != null) isMute = jsonMap["isMute"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
		if(jsonMap["updateAt"] != null) updateAt = jsonMap["updateAt"];
  }

  Conversation.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userIds"] != null) userIds = jsonMap["userIds"].cast<String>();
		if(jsonMap["latestMessage"] != null) latestMessage = jsonMap["latestMessage"];
		if(jsonMap["isMute"] != null) isMute = jsonMap["isMute"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
		if(jsonMap["updateAt"] != null) updateAt = jsonMap["updateAt"];
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
		jsonMap["userIds"] = userIds;
		jsonMap["latestMessage"] = latestMessage;
		jsonMap["isMute"] = isMute;
		jsonMap["isDeleted"] = isDeleted;
		jsonMap["createAt"] = createAt;
		jsonMap["updateAt"] = updateAt;
    return jsonMap;
  }
}
