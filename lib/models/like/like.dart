
import 'dart:convert';



class Like {
  String? id;

  Like({
    this.id,
  });

  Like.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
  }

  Like.fromStringJson(String stringJson) {
    Map valueMap = json.decode(stringJson);
    Like.fromJson(valueMap);
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