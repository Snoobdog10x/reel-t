// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';

enum NotificationType { NEW_MESSAGE,NEW_VIDEO,MENTIONS_YOU }


class Notification{
  static const String id_PATH = "id";
	String id = "";
	static const String userId_PATH = "userId";
	String userId = "";
	static const String notificationContent_PATH = "notificationContent";
	String notificationContent = "";
	static const String notificationType_PATH = "notificationType";
	String notificationType = "";
	static const String hasSeen_PATH = "hasSeen";
	bool hasSeen = false;
	static const String hasPushed_PATH = "hasPushed";
	bool hasPushed = false;
	static const String createAt_PATH = "createAt";
	int createAt = 0;
	static const String PATH = "Notifications";

  Notification({
    String? id,
		String? userId,
		String? notificationContent,
		String? notificationType,
		bool? hasSeen,
		bool? hasPushed,
		int? createAt,
  }){
    if(id != null) this.id = id;
		if(userId != null) this.userId = userId;
		if(notificationContent != null) this.notificationContent = notificationContent;
		if(notificationType != null) this.notificationType = notificationType;
		if(hasSeen != null) this.hasSeen = hasSeen;
		if(hasPushed != null) this.hasPushed = hasPushed;
		if(createAt != null) this.createAt = createAt;
  }

  Notification.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["notificationContent"] != null) notificationContent = jsonMap["notificationContent"];
		if(jsonMap["notificationType"] != null) notificationType = jsonMap["notificationType"];
		if(jsonMap["hasSeen"] != null) hasSeen = jsonMap["hasSeen"];
		if(jsonMap["hasPushed"] != null) hasPushed = jsonMap["hasPushed"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
  }

  Notification.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["notificationContent"] != null) notificationContent = jsonMap["notificationContent"];
		if(jsonMap["notificationType"] != null) notificationType = jsonMap["notificationType"];
		if(jsonMap["hasSeen"] != null) hasSeen = jsonMap["hasSeen"];
		if(jsonMap["hasPushed"] != null) hasPushed = jsonMap["hasPushed"];
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
		jsonMap["userId"] = userId;
		jsonMap["notificationContent"] = notificationContent;
		jsonMap["notificationType"] = notificationType;
		jsonMap["hasSeen"] = hasSeen;
		jsonMap["hasPushed"] = hasPushed;
		jsonMap["createAt"] = createAt;
    return jsonMap;
  }

  @override
  bool operator ==(Object other) =>
      other is Notification && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
