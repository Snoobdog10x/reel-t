import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  late String id;
  late String name;
  late String email;
  late String accountName;
  late String userAvatar;
  late String birthday;
  late String password;

  UserProfile({
    this.id = "",
    this.name = "",
    this.accountName = "",
    this.userAvatar = "",
    this.birthday = "",
    this.password = "",
  });

  void mergeFromFirebase(User? user) {
    id = user?.uid ?? "";
    name = user?.displayName ?? "";
    email = user?.email ?? "";
    userAvatar = user?.photoURL ?? "";
  }

  UserProfile.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    accountName = json['accountName'] ?? "";
    userAvatar = json['userAvatar'] ?? "";
    birthday = json['birthday'] ?? "";
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
    data['id'] = this.id;
    data['name'] = this.name;
    data['accountName'] = this.name;
    data['userAvatar'] = this.name;
    data['birthday'] = this.name;
    return data;
  }
}
