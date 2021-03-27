import 'dart:convert';
import 'dart:io';
import 'package:chocaycanh/model/Cateogies.dart';
import 'package:http/http.dart' as http;

import '../token.dart';

// Fetch our Categories from API
Future<List<Category>> fetchCategories() async {
  const String apiUrl = "https://chocaycanh.club/api/loaicaycanh";
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
//  final http.Response response = await client.get(
//       apiUrl,
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ' + ' ' + Token.token,
//       },
//       body: jsonEncode(<String, String>{
//         "password": pass,
//         "password_confirmation": pass,
//         "email": Myprofile.email,
//         "username": Myprofile.username,
//       }),
//     );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var body = json.decode(response.body);
    var data1 = body['data'] as List;
    List<Category> categories = new List();
    for (var item in data1) {
      var cat = Category.fromJson(item);
      print(cat.hinhanh);
      categories.add(cat);
    }

// It retuen list of categories
    print(categories);
    return categories;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}
