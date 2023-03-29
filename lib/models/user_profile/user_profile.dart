import 'dart:convert';
import '../../generated/abstract_model.dart';

class UserProfile extends AbstractModel{
  late String id;
	late String fullName;
	late String email;
	late String userName;
	late String bio;
	late String avatar;
	late int numFollower;
	late int numFollowing;
	late bool isOnline;
	late bool isActive;
	late bool isDeleted;
	static String PATH = "UserProfiles";

  UserProfile({
    String? id,
		String? fullName,
		String? email,
		String? userName,
		String? bio,
		String? avatar,
		int? numFollower,
		int? numFollowing,
		bool? isOnline,
		bool? isActive,
		bool? isDeleted,
  }){
    this.id = id ?? "";
		this.fullName = fullName ?? "";
		this.email = email ?? "";
		this.userName = userName ?? "";
		this.bio = bio ?? "";
		this.avatar = avatar ?? "";
		this.numFollower = numFollower ?? 0;
		this.numFollowing = numFollowing ?? 0;
		this.isOnline = isOnline ?? false;
		this.isActive = isActive ?? false;
		this.isDeleted = isDeleted ?? false;
  }

  UserProfile.fromJson(Map<dynamic, dynamic> jsonMap) {
    id = jsonMap["id"] ?? "";
		fullName = jsonMap["fullName"] ?? "";
		email = jsonMap["email"] ?? "";
		userName = jsonMap["userName"] ?? "";
		bio = jsonMap["bio"] ?? "";
		avatar = jsonMap["avatar"] ?? "";
		numFollower = jsonMap["numFollower"] ?? 0;
		numFollowing = jsonMap["numFollowing"] ?? 0;
		isOnline = jsonMap["isOnline"] ?? false;
		isActive = jsonMap["isActive"] ?? false;
		isDeleted = jsonMap["isDeleted"] ?? false;
  }

  UserProfile.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    id = jsonMap["id"] ?? "";
		fullName = jsonMap["fullName"] ?? "";
		email = jsonMap["email"] ?? "";
		userName = jsonMap["userName"] ?? "";
		bio = jsonMap["bio"] ?? "";
		avatar = jsonMap["avatar"] ?? "";
		numFollower = jsonMap["numFollower"] ?? 0;
		numFollowing = jsonMap["numFollowing"] ?? 0;
		isOnline = jsonMap["isOnline"] ?? false;
		isActive = jsonMap["isActive"] ?? false;
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
		data["fullName"] = this.fullName;
		data["email"] = this.email;
		data["userName"] = this.userName;
		data["bio"] = this.bio;
		data["avatar"] = this.avatar;
		data["numFollower"] = this.numFollower;
		data["numFollowing"] = this.numFollowing;
		data["isOnline"] = this.isOnline;
		data["isActive"] = this.isActive;
		data["isDeleted"] = this.isDeleted;
    return data;
  }
}
