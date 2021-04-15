class Ccchamsoc {
  final int id, idcaycanh;

  final String hoatdong, hinhanh, diadiem, created_at;

  Ccchamsoc({
    this.id,
    this.idcaycanh,
    this.hoatdong,
    this.hinhanh,
    this.diadiem,
    this.created_at,
  });

  // It create an Category from JSON
  factory Ccchamsoc.fromJson(Map<String, dynamic> json) {
    return Ccchamsoc(
      id: json["id"],
      idcaycanh: json["idcaycanh"],
      hoatdong: json["hoatdong"],
      diadiem: json["diadiem"],
      hinhanh: json["hinhanh"],
      created_at: json["created_at"],
    );
  }
}
