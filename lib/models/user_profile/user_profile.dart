import 'dart:convert';
import '../../generated/abstract_model.dart';




class UserProfile{
  String id = "";
	String fullName = "";
	String email = "";
	String userName = "";
	String bio = "";
	String avatar = "";
	int numFollower = 0;
	int numFollowing = 0;
	bool isOnline = false;
	bool isActive = false;
	bool isDeleted = false;
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
    if(id != null) this.id = id;
		if(fullName != null) this.fullName = fullName;
		if(email != null) this.email = email;
		if(userName != null) this.userName = userName;
		if(bio != null) this.bio = bio;
		if(avatar != null) this.avatar = avatar;
		if(numFollower != null) this.numFollower = numFollower;
		if(numFollowing != null) this.numFollowing = numFollowing;
		if(isOnline != null) this.isOnline = isOnline;
		if(isActive != null) this.isActive = isActive;
		if(isDeleted != null) this.isDeleted = isDeleted;
  }

  UserProfile.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["fullName"] != null) fullName = jsonMap["fullName"];
		if(jsonMap["email"] != null) email = jsonMap["email"];
		if(jsonMap["userName"] != null) userName = jsonMap["userName"];
		if(jsonMap["bio"] != null) bio = jsonMap["bio"];
		if(jsonMap["avatar"] != null) avatar = jsonMap["avatar"];
		if(jsonMap["numFollower"] != null) numFollower = jsonMap["numFollower"];
		if(jsonMap["numFollowing"] != null) numFollowing = jsonMap["numFollowing"];
		if(jsonMap["isOnline"] != null) isOnline = jsonMap["isOnline"];
		if(jsonMap["isActive"] != null) isActive = jsonMap["isActive"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
  }

  UserProfile.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["fullName"] != null) fullName = jsonMap["fullName"];
		if(jsonMap["email"] != null) email = jsonMap["email"];
		if(jsonMap["userName"] != null) userName = jsonMap["userName"];
		if(jsonMap["bio"] != null) bio = jsonMap["bio"];
		if(jsonMap["avatar"] != null) avatar = jsonMap["avatar"];
		if(jsonMap["numFollower"] != null) numFollower = jsonMap["numFollower"];
		if(jsonMap["numFollowing"] != null) numFollowing = jsonMap["numFollowing"];
		if(jsonMap["isOnline"] != null) isOnline = jsonMap["isOnline"];
		if(jsonMap["isActive"] != null) isActive = jsonMap["isActive"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
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
		jsonMap["fullName"] = fullName;
		jsonMap["email"] = email;
		jsonMap["userName"] = userName;
		jsonMap["bio"] = bio;
		jsonMap["avatar"] = avatar;
		jsonMap["numFollower"] = numFollower;
		jsonMap["numFollowing"] = numFollowing;
		jsonMap["isOnline"] = isOnline;
		jsonMap["isActive"] = isActive;
		jsonMap["isDeleted"] = isDeleted;
    return jsonMap;
  }
}
