import 'dart:convert';
import 'dart:io';

import 'package:chocaycanh/components/default_button.dart';
import 'package:chocaycanh/profile.dart';
import 'package:chocaycanh/screens/sign_in/components/custom_surfix_icon.dart';

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'package:http/http.dart' as http;

import '../../token.dart';

class Resetpassword extends StatelessWidget {
  static String routeName = "/resetpass";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(("Tạo lại mật khẩu")),
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        child: Formreset(),
      ),
    );
  }
}

class Formreset extends StatefulWidget {
  @override
  _FormresetState createState() => _FormresetState();
}

class _FormresetState extends State<Formreset> {
  final _formkey = GlobalKey<FormState>();
  String username;
  String email;
  String oldpassword;
  String password;
  String conform_password;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            buildPasswordFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            buildConformPasswordFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            DefaultButton(
              text: "Tiếp tục",
              press: () {
                if (_formkey.currentState.validate()) {
                  _formkey.currentState.save();

                  ///sau khi dang ky xong taikhoan thi chuyen sang complete
                  ///
                  postreset(username, email, password);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> postreset(String username, String mail, String pass) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    var dialog = CustomAlertDialog(
        title: "Logout",
        message: "Are you sure, do you want to logout?",
        onPostivePressed: () {},
        positiveBtnText: 'Yes',
        negativeBtnText: 'No');

    String devicename = "app";
    final http.Response response = await http.patch(
      linkupdateauth,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + ' ' + Token.token,
      },
      body: jsonEncode(<String, String>{
        "password": pass,
        "password_confirmation": pass,
        "email": Myprofile.email,
        "username": Myprofile.username,
      }),
    );
    errors.clear();
    debugPrint('trong phuong thuc dang nhap');
    debugPrint('code' + response.statusCode.toString());
    if (response.statusCode == 200) {
      // showDialog(context: context, builder: (BuildContext context) => dialog);
      Navigator.pop(context);
    } else {
      // showAlertDialog(context, 'thay đổi thất bại!');
    }
  }

  // showAlertDialog(BuildContext context, String alertstr) {
  //   // set up the button
  //   Widget okButton = FlatButton(
  //     child: Text("OK"),
  //     onPressed: () {},
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Thông báo"),
  //     content: Text(alertstr),
  //     actions: [
  //       okButton,
  //     ],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  TextFormField buildOldPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) {
        oldpassword = newValue;
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
        } else if (value == conform_password &&
            errors.contains(kMatchPassError)) {
          setState(() {
            errors.remove(kMatchPassError);
          });
        }
        setState(() {
          password = value;
        });

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
      //   obscureText: true,
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        hintText: "Điền mật khẩu hiện tại ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
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
        } else if (value == conform_password &&
            errors.contains(kMatchPassError)) {
          setState(() {
            errors.remove(kMatchPassError);
          });
        }
        setState(() {
          password = value;
        });

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
        } else if (conform_password != value &&
            !errors.contains(kMatchPassError)) {
          setState(() {
            errors.add(kMatchPassError);
          });
          return "";
        }

        return null;
      },
      //   obscureText: true,
      decoration: InputDecoration(
        labelText: "Mật khẩu mới",
        hintText: "Điền mật khẩu của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }

  TextFormField buildConformPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) {
        conform_password = newValue;
      },
      onChanged: (value) {
        if (password == value && errors.contains(kMatchPassError)) {
          setState(() {
            errors.remove(kMatchPassError);
          });
        }
        setState(() {
          conform_password = value;
        });

        return null;
      },
      validator: (value) {
        if (password != value && !errors.contains(kMatchPassError)) {
          setState(() {
            errors.add(kMatchPassError);
          });
          return "";
        }

        //
        return null;
      },
      //  obscureText: true,
      decoration: InputDecoration(
        labelText: "Nhập lại mật khẩu",
        hintText: "Điền lại mật khẩu của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final Function onPostivePressed;
  final Function onNegativePressed;
  final double circularBorderRadius;

  CustomAlertDialog({
    this.title,
    this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    this.positiveBtnText,
    this.negativeBtnText,
    this.onPostivePressed,
    this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title) : null,
      content: message != null ? Text(message) : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        negativeBtnText != null
            ? FlatButton(
                child: Text(negativeBtnText),
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onNegativePressed != null) {
                    onNegativePressed();
                  }
                },
              )
            : null,
        positiveBtnText != null
            ? FlatButton(
                child: Text(positiveBtnText),
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  if (onPostivePressed != null) {
                    onPostivePressed();
                  }
                },
              )
            : null,
      ],
    );
  }
}
