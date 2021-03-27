import 'dart:convert';
import 'dart:io';
import 'package:chocaycanh/model/products.dart';
import 'package:http/http.dart' as http;

import '../token.dart';

// Fetch our Products from API
Future<List<Product>> fetchProducts() async {
  const String apiUrl = "https://chocaycanh.club/api/dscaycanhmoi?soluong=6";

  // final response = await http.get(apiUrl);
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  final response = await http.get(apiUrl, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + ' ' + Token.token,
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var body = json.decode(response.body);
    var data1 = body['data'] as List;
    List<Product> products = new List();
    for (var item in data1) {
      var pro = Product.fromJson(item);

      products.add(pro);
    }

    // Return list of products
    return products;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

Future<List<Product>> fetchProductStore(int id) async {
  print('id:' + id.toString());
  String apiUrl = "https://chocaycanh.club/api/dscaycanh?id=" + id.toString();

  // final response = await http.get(apiUrl);
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  final response = await http.get(apiUrl, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + ' ' + Token.token,
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var body = json.decode(response.body);
    var data1 = body['data'] as List;
    List<Product> products = new List();
    for (var item in data1) {
      var pro = Product.fromJson(item);

      products.add(pro);
    }

    // Return list of products
    return products;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}
