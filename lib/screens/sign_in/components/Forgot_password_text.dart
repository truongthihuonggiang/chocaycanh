import 'package:chocaycanh/screens/forgot_password/forgot_password.dart';
import 'package:flutter/material.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.popAndPushNamed(context, ForgotPasswordScreen.routeName);
      },
      child: Text("quên mật khẩu",
          style: TextStyle(decoration: TextDecoration.underline)),
    );
  }
}
