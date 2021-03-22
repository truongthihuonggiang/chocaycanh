import 'dart:convert';
import 'dart:io';
import 'package:chocaycanh/model/Cateogies.dart';
import 'package:http/http.dart' as http;

// Fetch our Categories from API
Future<List<Category>> fetchCategories() async {
  const String apiUrl = "";

  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  final response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Category> categories = (json.decode(response.body) as List)
        .map((data) => Category.fromJson(data))
        .toList();
// It retuen list of categories
    //print(categories);
    return categories;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}
