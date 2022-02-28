class Buinfo {
  Buinfo({
    this.userName,
    this.userFamily,
    this.gender,
    this.userImage,
    this.isActive,
    this.roleId,
    this.permissions,
  });

  final String? userName;
  final String? userFamily;
  final bool? gender;
  final String? userImage;
  final bool? isActive;
  final int? roleId;
  final List<int>? permissions;

  factory Buinfo.fromJson(Map<String, dynamic> json) {
    return Buinfo(
      userName: json["userName"],
      userFamily: json["userFamily"],
      gender: json["gender"],
      userImage: json["userImage"],
      isActive: json["isActive"],
      roleId: json["roleId"],
      permissions: List<int>.from(json["permissions"].map((x) => x)),
    );
  }
}
