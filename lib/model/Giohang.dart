class Giohang {
  int id, idcay, soluong, soluongkho, dongia, dongiakhuyenmai, idcuahang, check;

  String ten, tencuahang, hinhmoi, created_at, updated_at;

  Giohang({
    this.id,
    this.idcay,
    this.soluong,
    this.soluongkho,
    this.dongia,
    this.dongiakhuyenmai,
    this.idcuahang,
    this.tencuahang,
    this.ten,
    this.hinhmoi,
    this.created_at,
    this.updated_at,
    check = 1,
  });

  // It create an Category from JSON
  factory Giohang.fromJson(Map<String, dynamic> json) {
    Giohang kq = Giohang(
      id: json["id"],
      idcay: json["idcay"],
      soluong: json["soluong"],
      soluongkho: json["soluongkho"],
      dongia: json["dongia"],
      hinhmoi: json["hinhmoi"],
      dongiakhuyenmai: json["dongiakhuyenmai"],
      idcuahang: json["idcuahang"],
      ten: json["ten"],
      tencuahang: json["tencuahang"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
    kq.check = 1;
    return kq;
  }
}
