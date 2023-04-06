// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';




class EmailOtp{
  static const String id_PATH = "id";
	String id = "";
	static const String otpCode_PATH = "otpCode";
	String otpCode = "";
	static const String verifyEmail_PATH = "verifyEmail";
	String verifyEmail = "";
	static const String isVerify_PATH = "isVerify";
	bool isVerify = false;
	static const String createAt_PATH = "createAt";
	int createAt = 0;
	static const String expireAt_PATH = "expireAt";
	int expireAt = 0;
	static const String PATH = "EmailOtps";

  EmailOtp({
    String? id,
		String? otpCode,
		String? verifyEmail,
		bool? isVerify,
		int? createAt,
		int? expireAt,
  }){
    if(id != null) this.id = id;
		if(otpCode != null) this.otpCode = otpCode;
		if(verifyEmail != null) this.verifyEmail = verifyEmail;
		if(isVerify != null) this.isVerify = isVerify;
		if(createAt != null) this.createAt = createAt;
		if(expireAt != null) this.expireAt = expireAt;
  }

  EmailOtp.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["otpCode"] != null) otpCode = jsonMap["otpCode"];
		if(jsonMap["verifyEmail"] != null) verifyEmail = jsonMap["verifyEmail"];
		if(jsonMap["isVerify"] != null) isVerify = jsonMap["isVerify"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
		if(jsonMap["expireAt"] != null) expireAt = jsonMap["expireAt"];
  }

  EmailOtp.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["otpCode"] != null) otpCode = jsonMap["otpCode"];
		if(jsonMap["verifyEmail"] != null) verifyEmail = jsonMap["verifyEmail"];
		if(jsonMap["isVerify"] != null) isVerify = jsonMap["isVerify"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
		if(jsonMap["expireAt"] != null) expireAt = jsonMap["expireAt"];
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
		jsonMap["otpCode"] = otpCode;
		jsonMap["verifyEmail"] = verifyEmail;
		jsonMap["isVerify"] = isVerify;
		jsonMap["createAt"] = createAt;
		jsonMap["expireAt"] = expireAt;
    return jsonMap;
  }
}
