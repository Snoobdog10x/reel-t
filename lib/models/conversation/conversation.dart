// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';
import '../../models/message/message.dart';
import '../../models/user_profile/user_profile.dart';
import 'package:hive/hive.dart';
part 'conversation.g.dart';


@HiveType(typeId: 0)
class Conversation extends HiveObject{
  @HiveField(0) 
	String id = "";
	@HiveField(1) 
	String firstUserId = "";
	@HiveField(2) 
	String secondUserId = "";
	@HiveField(3) 
	List<Message> messages = [];
	@HiveField(4) 
	List<UserProfile> secondUser = [];
	@HiveField(5) 
	bool isMute = false;
	@HiveField(6) 
	bool isDeleted = false;
	@HiveField(7) 
	int createAt = 0;
	static String PATH = "Conversations";

  Conversation({
    String? id,
		String? firstUserId,
		String? secondUserId,
		List<Message>? messages,
		List<UserProfile>? secondUser,
		bool? isMute,
		bool? isDeleted,
		int? createAt,
  }){
    if(id != null) this.id = id;
		if(firstUserId != null) this.firstUserId = firstUserId;
		if(secondUserId != null) this.secondUserId = secondUserId;
		if(messages != null) this.messages = messages;
		if(secondUser != null) this.secondUser = secondUser;
		if(isMute != null) this.isMute = isMute;
		if(isDeleted != null) this.isDeleted = isDeleted;
		if(createAt != null) this.createAt = createAt;
  }

  Conversation.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["firstUserId"] != null) firstUserId = jsonMap["firstUserId"];
		if(jsonMap["secondUserId"] != null) secondUserId = jsonMap["secondUserId"];
		if(jsonMap["isMute"] != null) isMute = jsonMap["isMute"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
  }

  Conversation.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["firstUserId"] != null) firstUserId = jsonMap["firstUserId"];
		if(jsonMap["secondUserId"] != null) secondUserId = jsonMap["secondUserId"];
		if(jsonMap["isMute"] != null) isMute = jsonMap["isMute"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
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
		jsonMap["firstUserId"] = firstUserId;
		jsonMap["secondUserId"] = secondUserId;
		jsonMap["isMute"] = isMute;
		jsonMap["isDeleted"] = isDeleted;
		jsonMap["createAt"] = createAt;
    return jsonMap;
  }
}
