class Boperationhistory {
  Boperationhistory({
    this.opname,
    this.opdate,
    this.optime,
    this.pack,
    this.shot,
    this.time,
    this.select,
    this.details,
  });

  final String? opname;
  final String? opdate;
  final String? optime;
  final String? pack;
  final int? shot;
  final int? time;
  bool? select;
  final List<Detail>? details;

  factory Boperationhistory.fromJson(Map<String, dynamic> json) =>
      Boperationhistory(
        opname: json["opname"],
        opdate: json["opdate"],
        optime: json["optime"],
        pack: json["pack"],
        shot: json["shot"],
        time: json["time"],
        select: false,
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "opname": opname,
        "opdate": opdate,
        "optime": optime,
        "pack": pack,
        "shot": shot,
        "time": time,
        "select": false,
        "details": List<Detail>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.area,
    this.amount,
    this.tip,
    this.handpis,
    this.moj,
    this.pals,
    this.energy,
    this.device,
  });

  final String? area;
  final String? amount;
  final String? tip;
  final int? handpis;
  final String? moj;
  final int? pals;
  final int? energy;
  final String? device;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        area: json["area"],
        amount: json["amount"],
        tip: json["tip"],
        handpis: json["handpis"],
        moj: json["moj"],
        pals: json["pals"],
        energy: json["energy"],
        device: json["device"],
      );

  Map<String, dynamic> toJson() => {
        "area": area,
        "amount": amount,
        "tip": tip,
        "handpis": handpis,
        "moj": moj,
        "pals": pals,
        "energy": energy,
        "device": device,
      };
}
