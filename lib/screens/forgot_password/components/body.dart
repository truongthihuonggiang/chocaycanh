import 'package:chocaycanh/screens/sign_in/components/no_account_text.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

import 'forgot_password_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              Text(
                "Quên mật khẩu",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Xin hãy điền email và chúng tôi sẽ gửi link để mình tạo lại mật khẩu.",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              ForgotPassForm(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              NoAccountText(),
            ],
          ),
        ),
      ),
    );
  }
}
