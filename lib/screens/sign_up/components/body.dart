import 'package:chocaycanh/components/social_card.dart';
import 'package:chocaycanh/constants.dart';

import 'package:chocaycanh/screens/sign_up/components/sign_up_form.dart';
import 'package:chocaycanh/screens/sign_up/components/signupcallback.dart';
import 'package:chocaycanh/size_config.dart';

import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> implements SignupCallback {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Column(
              children: [
                Text(
                  " Đăng ký tài khoản",
                  style: headingStyle,
                ),
                Text(
                  "Điền các thông tin sau hoặc có thể tiếp tục\n bằng tài khoản mạng xã hội",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                SignUpForm(callback: this),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    SocialCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                    SocialCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(
                      SizeConfig.screenHeight * 0.02),
                ),
                Text(
                    "Khi bạn tiệp tục đăng ký đồng nghĩa bạn đã đồng ý\nvới các điều khoản và quy định của chúng tôi")
              ],
            ),
            Container(
                child: isloading == true
                    ? Container(
                        width: double.infinity,
                        height: SizeConfig.screenHeight,
                        color: Color(0xFF0E3311).withOpacity(0.5),
                        child: Center(
                          child: Image.asset('assets/images/spinner.gif'),
                        ),
                      )
                    : Container()),
          ],
        ),
      ),
    );
  }

  @override
  bool capnhatloading(bool isloading) {
    // TODO: implement capnhatloading
    setState(() {
      this.isloading = isloading;
    });
  }
}
