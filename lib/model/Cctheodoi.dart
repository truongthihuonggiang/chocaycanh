class Cctheodoi {
  final int id, idcaycanh, moinhat, giatien;

  final String ghichu, hinhanh, created_at;

  Cctheodoi({
    this.id,
    this.idcaycanh,
    this.moinhat,
    this.giatien,
    this.ghichu,
    this.hinhanh,
    this.created_at,
  });

  // It create an Category from JSON
  factory Cctheodoi.fromJson(Map<String, dynamic> json) {
    return Cctheodoi(
      id: json["id"],
      idcaycanh: json["idcaycanh"],
      moinhat: json["moinhat"],
      ghichu: json["ghichu"],
      hinhanh: json["hinhanh"],
      created_at: json["created_at"],
      giatien: json["giatien"],
    );
  }
}
