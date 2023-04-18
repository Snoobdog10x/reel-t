// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:convert';
import '../../generated/abstract_model.dart';
import 'package:hive/hive.dart';
part 'search_history.g.dart';


@HiveType(typeId: 2)
class SearchHistory extends HiveObject{
  static const String id_PATH = "id";
	@HiveField(0) 
	String id = "";
	static const String searchText_PATH = "searchText";
	@HiveField(1) 
	String searchText = "";
	static const String isLocal_PATH = "isLocal";
	@HiveField(2) 
	bool isLocal = false;
	static const String createAt_PATH = "createAt";
	@HiveField(3) 
	int createAt = 0;
	static const String PATH = "SearchHistorys";

  SearchHistory({
    String? id,
		String? searchText,
		bool? isLocal,
		int? createAt,
  }){
    if(id != null) this.id = id;
		if(searchText != null) this.searchText = searchText;
		if(isLocal != null) this.isLocal = isLocal;
		if(createAt != null) this.createAt = createAt;
  }

  SearchHistory.fromJson(Map<dynamic, dynamic> jsonMap) {
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["searchText"] != null) searchText = jsonMap["searchText"];
		if(jsonMap["isLocal"] != null) isLocal = jsonMap["isLocal"];
		if(jsonMap["createAt"] != null) createAt = jsonMap["createAt"];
  }

  SearchHistory.fromStringJson(String stringJson) {
    Map jsonMap = json.decode(stringJson);
    if(jsonMap["id"] != null) id = jsonMap["id"];
		if(jsonMap["searchText"] != null) searchText = jsonMap["searchText"];
		if(jsonMap["isLocal"] != null) isLocal = jsonMap["isLocal"];
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
		jsonMap["searchText"] = searchText;
		jsonMap["isLocal"] = isLocal;
		jsonMap["createAt"] = createAt;
    return jsonMap;
  }

  @override
  bool operator ==(Object other) =>
      other is SearchHistory && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
