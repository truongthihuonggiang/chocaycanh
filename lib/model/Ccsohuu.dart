class Ccsohuu {
  final int id, idcaycanh, iduser, trangthai, idcuahang, machungtu;

  final String tennguoidung, tencuahang, diachi, created_at;

  Ccsohuu({
    this.id,
    this.idcaycanh,
    this.iduser,
    this.trangthai,
    this.tennguoidung,
    this.tencuahang,
    this.machungtu,
    this.diachi,
    this.idcuahang,
    this.created_at,
  });

  // It create an Category from JSON
  factory Ccsohuu.fromJson(Map<String, dynamic> json) {
    return Ccsohuu(
      id: json["id"],
      idcaycanh: json["idcaycanh"],
      iduser: json["iduser"],
      trangthai: json["trangthai"],
      tennguoidung: json["tennguoidung"],
      tencuahang: json["tencuahang"],
      machungtu: json["machungtu"],
      diachi: json["diachi"],
      idcuahang: json["idcuahang"],
      created_at: json["created_at"],
    );
  }
}
