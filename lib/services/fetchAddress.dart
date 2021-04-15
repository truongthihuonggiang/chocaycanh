import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../token.dart';

class Diadiem {
  final int id;
  final String ten;

  Diadiem({this.id, this.ten});
  factory Diadiem.fromTinhJson(Map<String, dynamic> json) {
    return Diadiem(
      id: json["ProvinceID"],
      ten: json["ProvinceName"],
    );
  }
  factory Diadiem.fromHuyenJson(Map<String, dynamic> json) {
    return Diadiem(
      id: json["DistrictID"],
      ten: json["DistrictName"],
    );
  }
  factory Diadiem.fromXaJson(Map<String, dynamic> json) {
    return Diadiem(
      id: int.parse(json["WardCode"]),
      ten: json["WardName"],
    );
  }
  static Future<List<Diadiem>> fetchHuyen(int idtinh) async {
    String apiUrl =
        "https://chocaycanh.club/api/getjshuyen?id=" + idtinh.toString();
    print('gui:' + apiUrl);
    // final response = await http.get(apiUrl);
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final response = await http.get(apiUrl, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });
    print('response:' + response.statusCode.toString());
    //  print('response:' + response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var body = json.decode(response.body);
      var data1 = body['data'] as List;
      List<Diadiem> ls = new List();
      for (var item in data1) {
        var cat = Diadiem.fromHuyenJson(item);

        ls.add(cat);
      }

// It retuen list of categories

      return ls;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }
}

Future<List<Diadiem>> fetchTinh() async {
  String apiUrl = "https://chocaycanh.club/api/getjstinh";
  print('gui:' + apiUrl);
  // final response = await http.get(apiUrl);
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  final response = await http.get(apiUrl, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    //   'Authorization': 'Bearer ' + ' ' + Token.token,
  });

  print('response:' + response.statusCode.toString());
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var body = json.decode(response.body);
    //  print(body);
    var data1 = body['data'] as List;
    List<Diadiem> ls = new List();
    for (var item in data1) {
      var cat = Diadiem.fromTinhJson(item);

      ls.add(cat);
    }

// It retuen list of categories

    return ls;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

Future<List<Diadiem>> fetchXa(int idhuyen) async {
  String apiUrl =
      "https://chocaycanh.club/api/getjsxa?id=" + idhuyen.toString();
  print('gui:' + apiUrl);
  // final response = await http.get(apiUrl);
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  final response = await http.get(apiUrl, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  });
  print('body:' + response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var body = json.decode(response.body);
    var data1 = body['data'] as List;
    List<Diadiem> ls = new List();
    for (var item in data1) {
      var cat = Diadiem.fromXaJson(item);

      ls.add(cat);
    }

// It retuen list of categories

    return ls;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}
