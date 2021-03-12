import 'package:chocaycanh/components/default_button.dart';
import 'package:chocaycanh/components/form_error.dart';
import 'package:chocaycanh/screens/EmailConform/email_conform.dart';
import 'package:chocaycanh/screens/login_success/login_success_screen.dart';
import 'package:chocaycanh/token.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'Forgot_password_text.dart';
import 'custom_surfix_icon.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:http_middleware/http_middleware.dart';
import 'package:http_logger/http_logger.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formkey = GlobalKey<FormState>();
  String email;
  String password;
  final List<String> errors = [];
  bool remember = false;

  @override
  Widget build(BuildContext context) {
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

  Future<Token> postlogin(String mail, String pass) async {
    HttpWithMiddleware httpClient = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    String devicename = "app";
//  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
    // devicename = androidInfo.model.toString();
    // //IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // //print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
    // //devicename = devicename + iosInfo.utsname.machine.toString();

    final http.Response response = await httpClient.post(
      linkLogin,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': email,
        'password': password,
        'device_name': devicename,
      }),
    );

    // final response = await http.post(
    //   'http://10.0.2.2/vanguard/public/api/login',
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //     'Accept': 'application/json',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'username': 'admin',
    //     'password': 'admin123',
    //     'device_name': "iPhone 11 Pro",
    //   }),
    // );
    debugPrint('trong phuong thuc dang nhap');
    debugPrint('$response.statusCode' + '');
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var token = Token.fromJson(jsonDecode(response.body));
      Navigator.pushNamed(context, LoginSuccessScreen.routeName);
      debugPrint('token: ' + Token.token);
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
