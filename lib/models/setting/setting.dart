// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';
import 'package:hive/hive.dart';
part 'setting.g.dart';


@HiveType(typeId: 1)
class Setting extends HiveObject{
  static const String id_PATH = "id";
	@HiveField(0) 
	String id = "";
	static const String userId_PATH = "userId";
	@HiveField(1) 
	String userId = "";
	static const String isTurnOffNotification_PATH = "isTurnOffNotification";
	@HiveField(2) 
	bool isTurnOffNotification = false;
	static const String isTurnOffTwoFa_PATH = "isTurnOffTwoFa";
	@HiveField(3) 
	bool isTurnOffTwoFa = false;
	static const String isShowActive_PATH = "isShowActive";
	@HiveField(4) 
	bool isShowActive = false;
	static const String createAt_PATH = "createAt";
	@HiveField(5) 
	int createAt = 0;
	static const String updateAt_PATH = "updateAt";
	@HiveField(6) 
	int updateAt = 0;
	static const String PATH = "Settings";

  Setting({
    String? id,
		String? userId,
		bool? isTurnOffNotification,
		bool? isTurnOffTwoFa,
		bool? isShowActive,
		int? createAt,
		int? updateAt,
  }){
    if(id != null) this.id = id;
		if(userId != null) this.userId = userId;
		if(isTurnOffNotification != null) this.isTurnOffNotification = isTurnOffNotification;
		if(isTurnOffTwoFa != null) this.isTurnOffTwoFa = isTurnOffTwoFa;
		if(isShowActive != null) this.isShowActive = isShowActive;
		if(createAt != null) this.createAt = createAt;
		if(updateAt != null) this.updateAt = updateAt;
  }

  Setting.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["isTurnOffNotification"] != null) isTurnOffNotification = jsonMap["isTurnOffNotification"];
		if(jsonMap["isTurnOffTwoFa"] != null) isTurnOffTwoFa = jsonMap["isTurnOffTwoFa"];
		if(jsonMap["isShowActive"] != null) isShowActive = jsonMap["isShowActive"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
		if(jsonMap["updateAt"] != null) updateAt = jsonMap["updateAt"];
  }

  Setting.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["userId"] != null) userId = jsonMap["userId"];
		if(jsonMap["isTurnOffNotification"] != null) isTurnOffNotification = jsonMap["isTurnOffNotification"];
		if(jsonMap["isTurnOffTwoFa"] != null) isTurnOffTwoFa = jsonMap["isTurnOffTwoFa"];
		if(jsonMap["isShowActive"] != null) isShowActive = jsonMap["isShowActive"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
		if(jsonMap["updateAt"] != null) updateAt = jsonMap["updateAt"];
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
		jsonMap["userId"] = userId;
		jsonMap["isTurnOffNotification"] = isTurnOffNotification;
		jsonMap["isTurnOffTwoFa"] = isTurnOffTwoFa;
		jsonMap["isShowActive"] = isShowActive;
		jsonMap["createAt"] = createAt;
		jsonMap["updateAt"] = updateAt;
    return jsonMap;
  }

  @override
  bool operator ==(Object other) =>
      other is Setting && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
