class Barea {
  Barea({
    this.id,
    this.area,
    this.selected,
  });

  final int? id;
  final String? area;
  bool? selected = false;

  factory Barea.fromJson(Map<String, dynamic> json) => Barea(
        id: json["id"],
        area: json["area"],
        selected: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "selected": false,
      };
}
