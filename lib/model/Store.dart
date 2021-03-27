class Store {
  final int id, iduser, diem;
  final String hinhanh,
      tencuahang,
      mota,
      madinhdanh,
      diachi,
      dienthoai,
      tentinh,
      website,
      created_at,
      updated_at;

  Store(
      {this.iduser,
      this.diem,
      this.tencuahang,
      this.madinhdanh,
      this.diachi,
      this.dienthoai,
      this.tentinh,
      this.hinhanh,
      this.mota,
      this.website,
      this.created_at,
      this.updated_at,
      this.id});

  // It creates an Category from JSON
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json["id"],
      hinhanh: json["hinhanh"],
      tencuahang: json["tencuahang"],
      mota: json["mota"],
      iduser: json["iduser"],
      diem: json["diem"],
      madinhdanh: json["madinhdanh"],
      diachi: json["diachi"],
      dienthoai: json["dienthoai"],
      website: json["website"],
      tentinh: json["tentinh"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
  }
}
