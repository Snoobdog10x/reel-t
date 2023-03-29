import 'dart:convert';
import '../../generated/abstract_model.dart';
import '../follow/follow.dart';

class UserProfile extends AbstractModel {
  late String id;
  late String fullName;
  late String email;
  late String userName;
  late String avatar;
  late String bio;
  late int numFollower;
  late int numFollowing;
  late bool isOnline;
  late bool isActive;
  late bool isDeleted;
  List<Follow> followings = [];
  List<Follow> followers = [];
  static String PATH = "UserProfiles";

  UserProfile({
    String? id,
    String? fullName,
    String? email,
    String? userName,
    String? avatar,
    String? bio,
    int? numFollower,
    int? numFollowing,
    bool? isOnline,
    bool? isActive,
    bool? isDeleted,
  }) {
    this.id = id ?? "";
    this.fullName = fullName ?? "";
    this.email = email ?? "";
    this.userName = userName ?? "";
    this.avatar = avatar ?? "";
    this.bio = bio ?? "";
    this.numFollower = numFollower ?? 0;
    this.numFollowing = numFollowing ?? 0;
    this.isOnline = isOnline ?? false;
    this.isActive = isActive ?? false;
    this.isDeleted = isDeleted ?? false;
  }

  UserProfile.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    fullName = json["fullName"];
    email = json["email"];
    userName = json["userName"];
    avatar = json["avatar"];
    bio = json["bio"];
    numFollower = json["numFollower"];
    numFollowing = json["numFollowing"];
    isOnline = json["isOnline"];
    isActive = json["isActive"];
    isDeleted = json["isDeleted"];
  }

  UserProfile.fromStringJson(String stringJson) {
    Map valueMap = json.decode(stringJson);
    id = valueMap["id"];
    fullName = valueMap["fullName"];
    email = valueMap["email"];
    userName = valueMap["userName"];
    avatar = valueMap["avatar"];
    bio = valueMap["bio"];
    numFollower = valueMap["numFollower"];
    numFollowing = valueMap["numFollowing"];
    isOnline = valueMap["isOnline"];
    isActive = valueMap["isActive"];
    isDeleted = valueMap["isDeleted"];
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
    data["fullName"] = this.fullName;
    data["email"] = this.email;
    data["userName"] = this.userName;
    data["avatar"] = this.avatar;
    data["bio"] = this.bio;
    data["numFollower"] = this.numFollower;
    data["numFollowing"] = this.numFollowing;
    data["isOnline"] = this.isOnline;
    data["isActive"] = this.isActive;
    data["isDeleted"] = this.isDeleted;
    return data;
  }
}
