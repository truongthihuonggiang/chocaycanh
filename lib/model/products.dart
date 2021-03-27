class Product {
  final int id,
      dongia,
      dongiakhuyenmai,
      namtrong,
      idloai,
      theodoi,
      soluong,
      yeuthich,
      idcuahang,
      congkhai;
  final String madinhdanh,
      ten,
      mota,
      tenloai,
      hinhmoi,
      created_at,
      updated_at,
      tencuahang;

  Product(
      {this.dongia,
      this.dongiakhuyenmai,
      this.namtrong,
      this.idloai,
      this.theodoi,
      this.soluong,
      this.yeuthich,
      this.congkhai,
      this.madinhdanh,
      this.ten,
      this.mota,
      this.tenloai,
      this.hinhmoi,
      this.idcuahang,
      this.created_at,
      this.updated_at,
      this.id,
      this.tencuahang});

  // It create an Category from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      dongia: json["dongia"],
      dongiakhuyenmai: json["dongiakhuyenmai"],
      namtrong: json["namtrong"],
      idloai: json["idloai"],
      theodoi: json["theodoi"],
      soluong: json["soluong"],
      yeuthich: json["yeuthich"],
      congkhai: json["congkhai"],
      madinhdanh: json["madinhdanh"],
      tencuahang: json["tencuahang"],
      ten: json["ten"],
      mota: json["mota"],
      tenloai: json["tenloai"],
      hinhmoi: json["hinhmoi"],
      idcuahang: json["idcuahang"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
  }
}

// Our Demo Product
// Product product = Product(
//   id: "1",
//   price: 1600,
//   title: "Wood Frame",
//   image: "https://i.imgur.com/sI4GvE6.png",
//   category: "Chair",
//   subTitle: "Tieton Armchair",
//   description: description,
// );

// String description =
//     "This armchair is an elegant and functional piece of furniture. It is suitable for family visits and parties with friends and perfect for relaxing in front of the TV after hard work.";
