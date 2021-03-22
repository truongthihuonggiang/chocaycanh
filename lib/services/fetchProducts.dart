import 'dart:convert';
import 'dart:io';
import 'package:chocaycanh/model/products.dart';
import 'package:http/http.dart' as http;

// Fetch our Products from API
Future<List<Product>> fetchProducts() async {
  const String apiUrl = "";

  // final response = await http.get(apiUrl);
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  final response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Product> products = (json.decode(response.body) as List)
        .map((data) => Product.fromJson(data))
        .toList();
    // Return list of products
    return products;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}
