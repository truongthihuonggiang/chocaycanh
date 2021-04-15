import 'package:chocaycanh/model/Ccchamsoc.dart';
import 'package:chocaycanh/model/Cctheodoi.dart';

import 'Ccsohuu.dart';

class Ccproduct {
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
      hinhanh,
      created_at,
      updated_at,
      tencuahang;
  List<Ccchamsoc> dschamsoc = new List();
  List<Cctheodoi> dstheodoi = new List();
  List<Ccsohuu> dssohuu = new List();
  Ccproduct(
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
      this.hinhanh,
      this.idcuahang,
      this.created_at,
      this.updated_at,
      this.id,
      this.tencuahang});

  // It create an Category from JSON
  factory Ccproduct.fromJson(Map<String, dynamic> json) {
    Ccproduct pro = new Ccproduct(
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
      hinhanh: json["hinhanh"],
      idcuahang: json["idcuahang"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
    var dstheodoi = json['dstheodoi'] as List;
    var dschamsoc = json['dschamsoc'] as List;
    var dssohuu = json['dssohuu'] as List;

    pro.dschamsoc = new List();
    for (var item in dschamsoc) {
      var cs = Ccchamsoc.fromJson(item);
      pro.dschamsoc.add(cs);
    }
    pro.dssohuu = new List();
    for (var item in dssohuu) {
      var sh = Ccsohuu.fromJson(item);
      pro.dssohuu.add(sh);
    }
    pro.dstheodoi = new List();
    for (var item in dstheodoi) {
      var sh = Cctheodoi.fromJson(item);
      pro.dstheodoi.add(sh);
    }
    return pro;
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
