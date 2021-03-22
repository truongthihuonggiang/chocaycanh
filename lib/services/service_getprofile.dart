import 'dart:convert';
import 'dart:io';
import 'package:chocaycanh/model/User.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../profile.dart';
import '../token.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

Future<User> updatelogin() async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  var response = await http.get(
    linkprofile,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + ' ' + Token.token,
    },
  );

  debugPrint('trong phuong thuc get profile service');

  debugPrint(response.body);
  if (response.statusCode == 200) {
    ////////////
    var data = json.decode(response.body);
    var users = data['data'];
    var user = User.fromJson(users);
    var profile = Myprofile.fromUser(user);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', user.username);
    prefs.setString('email', user.email);
    prefs.setString('avatar', user.avatar);
    prefs.setString('first_name', user.first_name);
    prefs.setString('last_name', user.last_name);
    prefs.setInt('id', user.id);
    prefs.setInt('role_id', user.role_id);
    debugPrint('avatar' + user.avatar);
    return user;
  } else {}
}
