import 'dart:convert';
import '../../models/message/message.dart';
import '../../models/user_profile/user_profile.dart';

import '../../generated/abstract_model.dart';

class Conversation extends AbstractModel {
  late String id;
  late String firstUserId;
  late String secondUserId;
  late bool isMute;
  late bool isDeleted;
  UserProfile? user1;
  UserProfile? user2;
  List<Message> messages = [];
  static String PATH = "Conversations";

  Conversation({
    String? id,
    String? firstUserId,
    String? secondUserId,
    bool? isMute,
    bool? isDeleted,
  }) {
    this.id = id ?? "";
    this.firstUserId = firstUserId ?? "";
    this.secondUserId = secondUserId ?? "";
    this.isMute = isMute ?? false;
    this.isDeleted = isDeleted ?? false;
  }

  Conversation.fromJson(Map<dynamic, dynamic> jsonMap) {
    id = jsonMap["id"] ?? "";
    firstUserId = jsonMap["firstUserId"] ?? "";
    secondUserId = jsonMap["secondUserId"] ?? "";
    isMute = jsonMap["isMute"] ?? false;
    isDeleted = jsonMap["isDeleted"] ?? false;
  }

  Conversation.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    id = jsonMap["id"] ?? "";
    firstUserId = jsonMap["firstUserId"] ?? "";
    secondUserId = jsonMap["secondUserId"] ?? "";
    isMute = jsonMap["isMute"] ?? false;
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
    data["firstUserId"] = this.firstUserId;
    data["secondUserId"] = this.secondUserId;
    data["isMute"] = this.isMute;
    data["isDeleted"] = this.isDeleted;
    return data;
  }
}
