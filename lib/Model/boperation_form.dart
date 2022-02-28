import 'dart:convert';

Boperationform boperationformFromJson(String str) =>
    Boperationform.fromJson(json.decode(str));

String boperationformToJson(Boperationform data) => json.encode(data.toJson());

class Boperationform {
  Boperationform({
    this.amount,
    this.tip,
    this.handpis,
    this.device,
    this.moj,
  });

  List<Amount>? amount;
  List<Amount>? tip;
  List<Handpi>? handpis;
  List<Amount>? device;
  List<Amount>? moj;

  factory Boperationform.fromJson(Map<String, dynamic> json) => Boperationform(
        amount:
            List<Amount>.from(json["amount"].map((x) => Amount.fromJson(x))),
        tip: List<Amount>.from(json["tip"].map((x) => Amount.fromJson(x))),
        handpis:
            List<Handpi>.from(json["handpis"].map((x) => Handpi.fromJson(x))),
        device:
            List<Amount>.from(json["device"].map((x) => Amount.fromJson(x))),
        moj: List<Amount>.from(json["moj"].map((x) => Amount.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "amount": List<dynamic>.from(amount!.map((x) => x.toJson())),
        "tip": List<dynamic>.from(tip!.map((x) => x.toJson())),
        "handpis": List<dynamic>.from(handpis!.map((x) => x.toJson())),
        "device": List<dynamic>.from(device!.map((x) => x.toJson())),
        "moj": List<dynamic>.from(moj!.map((x) => x.toJson())),
      };
}

class Amount {
  Amount({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class Handpi {
  Handpi({
    this.id,
    this.value,
  });

  int? id;
  int? value;

  factory Handpi.fromJson(Map<String, dynamic> json) => Handpi(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}
