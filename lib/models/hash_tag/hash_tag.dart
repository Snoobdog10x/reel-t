// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';




class HashTag{
  static const String id_PATH = "id";
	String id = "";
	static const String hashTagName_PATH = "hashTagName";
	String hashTagName = "";
	static const String createAt_PATH = "createAt";
	int createAt = 0;
	static const String updateAt_PATH = "updateAt";
	int updateAt = 0;
	static const String delete_PATH = "delete";
	bool delete = false;
	static const String PATH = "HashTags";

  HashTag({
    String? id,
		String? hashTagName,
		int? createAt,
		int? updateAt,
		bool? delete,
  }){
    if(id != null) this.id = id;
		if(hashTagName != null) this.hashTagName = hashTagName;
		if(createAt != null) this.createAt = createAt;
		if(updateAt != null) this.updateAt = updateAt;
		if(delete != null) this.delete = delete;
  }

  HashTag.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["hashTagName"] != null) hashTagName = jsonMap["hashTagName"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
		if(jsonMap["updateAt"] != null) updateAt = jsonMap["updateAt"];
		if(jsonMap["delete"] != null) delete = jsonMap["delete"];
  }

  HashTag.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["hashTagName"] != null) hashTagName = jsonMap["hashTagName"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
		if(jsonMap["updateAt"] != null) updateAt = jsonMap["updateAt"];
		if(jsonMap["delete"] != null) delete = jsonMap["delete"];
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
		jsonMap["hashTagName"] = hashTagName;
		jsonMap["createAt"] = createAt;
		jsonMap["updateAt"] = updateAt;
		jsonMap["delete"] = delete;
    return jsonMap;
  }

  @override
  bool operator ==(Object other) =>
      other is HashTag && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
