
import 'dart:convert';



class UserProfile {
  String? id;
	String? fullName;
	String? email;
	String? displayName;
	String? avatar;
	String? numFollower;
	String? numFollowing;
	bool? isOnline;
	bool? isActive;
	bool? isDeleted;

  UserProfile({
    this.id,
		this.fullName,
		this.email,
		this.displayName,
		this.avatar,
		this.numFollower,
		this.numFollowing,
		this.isOnline,
		this.isActive,
		this.isDeleted,
  });

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