import 'dart:convert';

Boperation boperationFromJson(String str) =>
    Boperation.fromJson(json.decode(str));

String boperationToJson(Boperation data) => json.encode(data.toJson());

class Boperation {
  Boperation({
    this.id,
    this.userName,
    this.userFamily,
    this.regtime,
    this.status,
    this.gender,
  });

  final int? id;
  final String? userName;
  final String? userFamily;
  final String? regtime;
  final String? status;
  final int? gender;

  factory Boperation.fromJson(Map<String, dynamic> json) => Boperation(
        id: json["id"],
        userName: json["userName"],
        userFamily: json["userFamily"],
        regtime: json["regtime"],
        status: json["status"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "userFamily": userFamily,
        "regtime": regtime,
        "status": status,
        "gender": gender,
      };
}
