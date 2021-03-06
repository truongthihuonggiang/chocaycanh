import 'dart:convert';
import 'dart:io';
import 'package:chocaycanh/screens/sign_up/components/signupcallback.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:chocaycanh/components/default_button.dart';
import 'package:chocaycanh/components/form_error.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/screens/EmailConform/email_conform.dart';

import 'package:chocaycanh/screens/sign_in/components/custom_surfix_icon.dart';
import 'package:chocaycanh/screens/sign_in/sign_in_screen.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  final SignupCallback callback;

  const SignUpForm({Key key, this.callback}) : super(key: key);
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formkey = GlobalKey<FormState>();
  String username;
  String email;
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
            buildUsernameFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            buildEmailFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            buildPasswordFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            buildConformPasswordFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            FormError(errors: errors),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            DefaultButton(
              text: "Ti???p t???c",
              press: () async {
                if (_formkey.currentState.validate()) {
                  _formkey.currentState.save();
                  FocusScope.of(context).unfocus();

                  ///sau khi dang ky xong taikhoan thi chuyen sang complete
                  ///
                  widget.callback.capnhatloading(true);
                  await postSignup(username, email, password);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> postSignup(String username, String mail, String pass) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    String devicename = "app";
    final http.Response response = await http.post(
      linkRegister,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "email": mail,
        "password": pass,
        "password_confirmation": pass,
        "tos": 'true',
      }),
    );
    errors.clear();
    debugPrint('trong phuong thuc dang nhap');
    debugPrint('$response.statusCode' + '');
    // setState(() {
    //   isloading = false;
    // });
    widget.callback.capnhatloading(false);
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var requires_email_confirmation =
          jsonDecode(response.body)['requires_email_confirmation'];
      // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
      //debugPrint('requires_email_confirmation: ' + requires_email_confirmation);
      if (requires_email_confirmation == true) {
        Navigator.popAndPushNamed(context, EmailConformScreen.routeName);
      } else {
        Navigator.popAndPushNamed(context, SignInScreen.routeName);
      }
    } else {
      if (response.statusCode == 422) {
        var mess = json.decode(response.body);
        var m_errors = mess['errors'];
        if (m_errors['email'] != null &&
            !errors.contains(m_errors['email'][0])) {
          setState(() {
            errors.add(m_errors['email'][0]);
          });
        }
        if (m_errors['username'] != null &&
            !errors.contains(m_errors['username'][0])) {
          setState(() {
            errors.add(m_errors['username'][0]);
          });
        }
      } else {
        throw Exception('Kh??ng x??c ?????nh l???i trong ????ng k??');
      }
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

    }
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
        labelText: "M???t kh???u",
        hintText: "??i???n m???t kh???u c???a b???n",
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
        labelText: "Nh???p l???i m???t kh???u",
        hintText: "??i???n l???i m???t kh???u c???a b???n",
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
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
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
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "??i???n email c???a b???n",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onSaved: (newValue) => username = newValue,
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
        labelText: "T??n ????ng nh???p",
        hintText: "??i???n t??n ????ng nh???p c???a b???n",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }
}
