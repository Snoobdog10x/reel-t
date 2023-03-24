
import 'dart:convert';



class UserProfile {
  late String id;
	late String fullName;
	late String email;
	late String displayName;
	late String avatar;
	late int numFollower;
	late int numFollowing;
	late bool isOnline;
	late bool isActive;
	late bool isDeleted;
  UserProfile({
    String? id,
		String? fullName,
		String? email,
		String? displayName,
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
		this.displayName = displayName ?? "";
		this.avatar = avatar ?? "";
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
		displayName = json["displayName"];
		avatar = json["avatar"];
		numFollower = json["numFollower"];
		numFollowing = json["numFollowing"];
		isOnline = json["isOnline"];
		isActive = json["isActive"];
		isDeleted = json["isDeleted"];
  }

  UserProfile.fromStringJson(String stringJson) {
    Map valueMap = json.decode(stringJson);
    UserProfile.fromJson(valueMap);
  }

  String toStringJson() {
    return json.encode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
		data["fullName"] = this.fullName;
		data["email"] = this.email;
		data["displayName"] = this.displayName;
		data["avatar"] = this.avatar;
		data["numFollower"] = this.numFollower;
		data["numFollowing"] = this.numFollowing;
		data["isOnline"] = this.isOnline;
		data["isActive"] = this.isActive;
		data["isDeleted"] = this.isDeleted;
    return data;
  }
}