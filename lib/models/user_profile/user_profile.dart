// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';
import 'package:hive/hive.dart';
part 'user_profile.g.dart';


@HiveType(typeId: 1)
class UserProfile extends HiveObject{
  static const String id_PATH = "id";
	@HiveField(0) 
	String id = "";
	static const String fullName_PATH = "fullName";
	@HiveField(1) 
	String fullName = "";
	static const String email_PATH = "email";
	@HiveField(2) 
	String email = "";
	static const String userName_PATH = "userName";
	@HiveField(3) 
	String userName = "";
	static const String bio_PATH = "bio";
	@HiveField(4) 
	String bio = "";
	static const String avatar_PATH = "avatar";
	@HiveField(5) 
	String avatar = "";
	static const String numFollower_PATH = "numFollower";
	@HiveField(6) 
	int numFollower = 0;
	static const String numFollowing_PATH = "numFollowing";
	@HiveField(7) 
	int numFollowing = 0;
	static const String numLikes_PATH = "numLikes";
	@HiveField(8) 
	int numLikes = 0;
	static const String isOnline_PATH = "isOnline";
	@HiveField(9) 
	bool isOnline = false;
	static const String isActive_PATH = "isActive";
	@HiveField(10) 
	bool isActive = false;
	static const String isDeleted_PATH = "isDeleted";
	@HiveField(11) 
	bool isDeleted = false;
	static const String createAt_PATH = "createAt";
	@HiveField(12) 
	int createAt = 0;
	static const String PATH = "UserProfiles";

  UserProfile({
    String? id,
		String? fullName,
		String? email,
		String? userName,
		String? bio,
		String? avatar,
		int? numFollower,
		int? numFollowing,
		int? numLikes,
		bool? isOnline,
		bool? isActive,
		bool? isDeleted,
		int? createAt,
  }){
    if(id != null) this.id = id;
		if(fullName != null) this.fullName = fullName;
		if(email != null) this.email = email;
		if(userName != null) this.userName = userName;
		if(bio != null) this.bio = bio;
		if(avatar != null) this.avatar = avatar;
		if(numFollower != null) this.numFollower = numFollower;
		if(numFollowing != null) this.numFollowing = numFollowing;
		if(numLikes != null) this.numLikes = numLikes;
		if(isOnline != null) this.isOnline = isOnline;
		if(isActive != null) this.isActive = isActive;
		if(isDeleted != null) this.isDeleted = isDeleted;
		if(createAt != null) this.createAt = createAt;
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
		if(jsonMap["numLikes"] != null) numLikes = jsonMap["numLikes"];
		if(jsonMap["isOnline"] != null) isOnline = jsonMap["isOnline"];
		if(jsonMap["isActive"] != null) isActive = jsonMap["isActive"];
		if(jsonMap["isDeleted"] != null) isDeleted = jsonMap["isDeleted"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
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
		if(jsonMap["numLikes"] != null) numLikes = jsonMap["numLikes"];
		if(jsonMap["isOnline"] != null) isOnline = jsonMap["isOnline"];
		if(jsonMap["isActive"] != null) isActive = jsonMap["isActive"];
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
		jsonMap["fullName"] = fullName;
		jsonMap["email"] = email;
		jsonMap["userName"] = userName;
		jsonMap["bio"] = bio;
		jsonMap["avatar"] = avatar;
		jsonMap["numFollower"] = numFollower;
		jsonMap["numFollowing"] = numFollowing;
		jsonMap["numLikes"] = numLikes;
		jsonMap["isOnline"] = isOnline;
		jsonMap["isActive"] = isActive;
		jsonMap["isDeleted"] = isDeleted;
		jsonMap["createAt"] = createAt;
    return jsonMap;
  }

  @override
  bool operator ==(Object other) =>
      other is UserProfile && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
