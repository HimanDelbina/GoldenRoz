import 'dart:convert';

AreaModel areaModelFromJson(String str) => AreaModel.fromJson(json.decode(str));

String areaModelToJson(AreaModel data) => json.encode(data.toJson());

class AreaModel {
  AreaModel({
    this.areaId,
  });

  int? areaId;

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        areaId: json["area_id"],
      );

  Map<String, dynamic> toJson() => {
        "area_id": areaId,
      };
}
