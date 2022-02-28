import 'dart:convert';

BoperationformPost boperationformPostFromJson(String str) =>
    BoperationformPost.fromJson(json.decode(str));

String boperationformPostToJson(BoperationformPost data) =>
    json.encode(data.toJson());

class BoperationformPost {
  BoperationformPost({
    this.pals,
    this.energy,
  });

  List<Energy>? pals;
  List<Energy>? energy;

  factory BoperationformPost.fromJson(Map<String, dynamic> json) =>
      BoperationformPost(
        pals: List<Energy>.from(json["pals"].map((x) => Energy.fromJson(x))),
        energy:
            List<Energy>.from(json["energy"].map((x) => Energy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pals": List<dynamic>.from(pals!.map((x) => x.toJson())),
        "energy": List<dynamic>.from(energy!.map((x) => x.toJson())),
      };
}

class Energy {
  Energy({
    this.id,
    this.value,
  });

  int? id;
  int? value;

  factory Energy.fromJson(Map<String, dynamic> json) => Energy(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}
