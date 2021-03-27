import 'dart:convert';
import 'dart:io';
import 'package:chocaycanh/model/Store.dart';
import 'package:http/http.dart' as http;
import '../token.dart';

// Fetch our Categories from API
Future<Store> getStore(int id) async {
  String apiUrl = "https://chocaycanh.club/api/cuahang/xem?id=" + id.toString();
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
    var data1 = body['data'];
    Store store = Store.fromJson(data1);

// It retuen list of categories
    //  print(stores);
    return store;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

Future<List<Store>> fetchStore() async {
  const String apiUrl = "https://chocaycanh.club/api/cuahang";
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
    List<Store> stores = new List();
    for (var item in data1) {
      var cat = Store.fromJson(item);
      print(cat.hinhanh);
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
