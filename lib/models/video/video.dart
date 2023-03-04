
import 'dart:convert';

class Video {
  String? id;

  Video({
    this.id = "",
  });

  Video.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"] ?? "";
  }

  Video.fromStringJson(String stringJson) {
    Map valueMap = json.decode(stringJson);
    Video.fromJson(valueMap);
  }

  String toStringJson() {
    return json.encode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    return data;
  }
}