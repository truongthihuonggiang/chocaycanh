import 'dart:io';

import 'package:chocaycanh/components/default_button.dart';
import 'package:chocaycanh/components/form_error.dart';
import 'package:chocaycanh/model/User.dart';
import 'package:chocaycanh/profile.dart';
import 'package:chocaycanh/screens/EmailConform/email_conform.dart';
import 'package:chocaycanh/screens/home/home_screen.dart';
import 'package:chocaycanh/services/service_getprofile.dart';

import 'package:chocaycanh/token.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'Forgot_password_text.dart';
import 'custom_surfix_icon.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formkey = GlobalKey<FormState>();
  String email;
  String password;
  final List<String> errors = [];
  bool remember = true;

  @override
  Widget build(BuildContext context) {
    checklogin();
    return Form(
      key: _formkey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Row(
            children: [
              Checkbox(
                value: remember,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Nhớ tôi"),
              Spacer(),
              ForgotPasswordText()
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          DefaultButton(
            text: "Tiếp tục",
            press: () {
              if (_formkey.currentState.validate()) {
                _formkey.currentState.save();
                debugPrint('trong phuong thuc dang nhap 1');

                ///sau khi dang nhap xong thi chuyen sang man hinh success
                ///
                postlogin(email, password);
                //       Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          )
        ],
      ),
    );
  }

  Future<Token> checklogin() async {
    final prefs = await SharedPreferences.getInstance();
    final String myUsername = prefs.getString('username') ?? "";
    final String myPass = prefs.getString('password') ?? "";
    final String myToken = prefs.getString('token') ?? "";
    debugPrint("token:" + myToken);
    if (myToken != "") {
      Token.token = myToken;

      updatelogin();
    }
  }

  Future<User> getprofile1() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    var response = await http.post(
      linkprofile,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + ' ' + Token.token,
      },
    );

    debugPrint('trong phuong thuc get profile sign form');
    debugPrint('statuscode:' + response.statusCode.toString());
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
      Navigator.pushNamed(context, HomeScreen.routeName);
      return user;
    } else {
      return null;
    }
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
  }

  Future<Token> postlogin(String mail, String pass) async {
    HttpClient client = new HttpClient();
    String devicename = "app";
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    var response = await http.post(
      linkLogin,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': mail,
        'password': pass,
        'device_name': devicename,
      }),
    );

    debugPrint('trong phuong thuc dang nhap');
    debugPrint('$response.statusCode' + '');
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //luu gia tri dang nhap

      ////////////
      var token = Token.fromJson(jsonDecode(response.body));
      Navigator.pushNamed(context, HomeScreen.routeName);
      debugPrint('token: ' + Token.token);
      if (remember == true) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('username', email);
        prefs.setString('password', password);
        prefs.setString('token', Token.token);
      }
      checklogin();
      return token;
    } else {
      var mess = json.decode(response.body);
      var m_errors = mess['errors'];
      errors.clear();
      if (response.statusCode == 401) {
        if (mess['message'] != null && !errors.contains(mess['message'])) {
          setState(() {
            errors.add(mess['message']);
          });
        }
        if (mess['token'] != null) {
          Token.token = mess['token'];
          Navigator.popAndPushNamed(context, EmailConformScreen.routeName);
        }
      } else {
        if (response.statusCode == 422) {
          if (m_errors['username'] != null &&
              !errors.contains(m_errors['username'][0])) {
            setState(() {
              errors.add(m_errors['username'][0]);
            });
          }
        } else {}
      }
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

    }
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) {
        password = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }

        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        } else if (value.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
          return "";
        }

        return null;
      },
      obscureText: true,
      initialValue: password,
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        hintText: "Điền mật khẩu của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
          return "";
        }
        return null;
      },
      initialValue: email,
      decoration: InputDecoration(
        labelText: "Tên đăng nhập",
        hintText: "Điền tên đăng nhập của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }
}
