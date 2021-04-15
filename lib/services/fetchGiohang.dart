import 'dart:convert';
import 'dart:io';
import 'package:chocaycanh/model/Giohang.dart';
import 'package:chocaycanh/model/Store.dart';
import 'package:chocaycanh/model/products.dart';
import 'package:http/http.dart' as http;
import '../token.dart';

Future<List<Giohang>> fetchGiohang() async {
  const String apiUrl = "https://chocaycanh.club/api/dsgiohang";
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);

  final response = await http.get(
    apiUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + ' ' + Token.token,
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var body = json.decode(response.body);
    var data1 = body['data'] as List;
    List<Giohang> stores = new List();
    for (var item in data1) {
      var cat = Giohang.fromJson(item);

      stores.add(cat);
    }

// It retuen list of categories
    //  print(stores);
    return stores;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

int numcart = 2;
//http://localhost/caycanh/public/api/capnhatsoluonggh
Future<void> postCnsoluonggiohang(int id, int soluong) async {
  String apiUrl = "https://chocaycanh.club/api/capnhatsoluonggh";

  // final response = await http.get(apiUrl);
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  final response = await http.post(
    apiUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + ' ' + Token.token,
    },
    body: jsonEncode(<String, String>{
      'id': id.toString(),
      'soluong': soluong.toString(),
    }),
  );
  print('reponse code' + response.statusCode.toString());
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print('cn thanh cong');

    // Return list of products

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

Future<void> postThemgiohang(Product product) async {
  String apiUrl = "https://chocaycanh.club/api/themgiohang";

  // final response = await http.get(apiUrl);
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  final response = await http.post(
    apiUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + ' ' + Token.token,
    },
    body: jsonEncode(<String, String>{
      'idcaycanh': product.id.toString(),
      'dongia': product.dongiakhuyenmai == null
          ? product.dongia.toString()
          : product.dongiakhuyenmai.toString(),
      'soluong': '1'
    }),
  );
  print('reponse code' + response.statusCode.toString());
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var body = json.decode(response.body);

    numcart = int.parse(response.body);
    print("so item: " + numcart.toString());
    ;

    // Return list of products

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}
