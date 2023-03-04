
import 'dart:convert';

class UserProfile {
  String? id;
	String? name;
	String? email;

  UserProfile({
    this.id = "",
		this.name = "",
		this.email = "",
  });

  UserProfile.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"] ?? "";
		name = json["name"] ?? "";
		email = json["email"] ?? "";
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
		data["name"] = this.name;
		data["email"] = this.email;
    return data;
  }
}