// To parse this JSON data, do
//
//     final historyJalasatModel = historyJalasatModelFromJson(jsonString);

import 'dart:convert';

HistoryJalasatModel historyJalasatModelFromJson(String str) =>
    HistoryJalasatModel.fromJson(json.decode(str));

String historyJalasatModelToJson(HistoryJalasatModel data) =>
    json.encode(data.toJson());

class HistoryJalasatModel {
  HistoryJalasatModel({
    this.id,
    this.area,
    this.amount,
    this.tip,
    this.handpis,
    this.moj,
    this.device,
    this.pals,
    this.energy,
    this.select,
  });

  int? id;
  String? area;
  String? amount;
  String? tip;
  int? handpis;
  String? moj;
  String? device;
  int? pals;
  int? energy;
  bool? select;

  factory HistoryJalasatModel.fromJson(Map<String, dynamic> json) =>
      HistoryJalasatModel(
        id: json["id"],
        area: json["area"],
        amount: json["amount"],
        tip: json["tip"],
        handpis: json["handpis"],
        moj: json["moj"],
        device: json["device"],
        pals: json["pals"],
        energy: json["energy"],
        select: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "amount": amount,
        "tip": tip,
        "handpis": handpis,
        "moj": moj,
        "device": device,
        "pals": pals,
        "energy": energy,
        "select": false,
      };
}
