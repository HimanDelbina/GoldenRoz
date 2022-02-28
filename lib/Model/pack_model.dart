// To parse this JSON data, do
//
//     final packModel = packModelFromJson(jsonString);

import 'dart:convert';

PackModel packModelFromJson(String str) => PackModel.fromJson(json.decode(str));

String packModelToJson(PackModel data) => json.encode(data.toJson());

class PackModel {
  PackModel({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory PackModel.fromJson(Map<String, dynamic> json) => PackModel(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
