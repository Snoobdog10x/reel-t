// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';
import '../../models/user_profile/user_profile.dart';
import '../../models/message/message.dart';
import 'package:hive/hive.dart';
part 'conversation.g.dart';


@HiveType(typeId: 0)
class Conversation extends HiveObject{
  static const String id_PATH = "id";
	@HiveField(0) 
	String id = "";
	static const String userIds_PATH = "userIds";
	@HiveField(1) 
	List<String> userIds = [];
	static const String contactUser_PATH = "contactUser";
	@HiveField(2) 
	List<UserProfile> contactUser = [];
	static const String latestMessage_PATH = "latestMessage";
	@HiveField(3) 
	List<Message> latestMessage = [];
	static const String isMute_PATH = "isMute";
	@HiveField(4) 
	bool isMute = false;
	static const String isDeleted_PATH = "isDeleted";
	@HiveField(5) 
	bool isDeleted = false;
	static const String createAt_PATH = "createAt";
	@HiveField(6) 
	int createAt = 0;
	static const String updateAt_PATH = "updateAt";
	@HiveField(7) 
	int updateAt = 0;
	static const String PATH = "Conversations";

  Conversation({
    String? id,
		List<String>? userIds,
		List<UserProfile>? contactUser,
		List<Message>? latestMessage,
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
		if(jsonMap["isMute"] != null) isMute = jsonMap["isMute"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
		if(jsonMap["updateAt"] != null) updateAt = jsonMap["updateAt"];
  }

  Conversation.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userIds"] != null) userIds = jsonMap["userIds"].cast<String>();
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
		jsonMap["isMute"] = isMute;
		jsonMap["isDeleted"] = isDeleted;
		jsonMap["createAt"] = createAt;
		jsonMap["updateAt"] = updateAt;
    return jsonMap;
  }
}
