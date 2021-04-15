import 'dart:convert';
import 'dart:io';

import 'package:chocaycanh/components/FormNotice.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:chocaycanh/token.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ResendEmailRegister extends StatefulWidget {
  @override
  _ResendEmailRegisterState createState() => _ResendEmailRegisterState();
}

class _ResendEmailRegisterState extends State<ResendEmailRegister> {
  final List<String> messages = [];
  @override
  Widget build(BuildContext context) {
    return buildResendText();
  }

  Column buildResendText() {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.04,
        ),
        Text(
          "Bạn cần vào hộp thư của email đăng ký để xác thực tài khoản.",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                postResendemail();
              },
              child: Text(
                " Gửi lại",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: kPrimaryColor),
              ),
            ),
            Text(
              " email. ",
              style: TextStyle(fontSize: getProportionateScreenWidth(16)),
            ),
          ],
        ),
        FormNotice(messages: messages),
      ],
    );
  }

  Future<void> postResendemail() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    String token = Token.token;

    final http.Response response = await http.post(
      "http://10.0.2.2/vanguard/public/api/email/resendm",
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    // debugPrint('trong phuong thuc dang nhap');

    if (response.statusCode == 202) {
      setState(() {
        messages.clear();
        messages.add("Đã gửi thành công!");
      });
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      setState(() {
        messages.clear();
        messages.add("Không thực hiện gửi được!");
      });
    }
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: ResendEmailRegister(),
        ),
      ),
    );
  }
}
