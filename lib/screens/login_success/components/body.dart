import 'package:chocaycanh/components/default_button.dart';
import 'package:chocaycanh/screens/home/home_screen.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(children: [
        Spacer(),
        SizedBox(
          height: SizeConfig.screenHeight * 0.04,
        ),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4,
          width: SizeConfig.screenWidth,
          fit: BoxFit.fitWidth,
        ),
        Spacer(),
        Text(
          "Login Success",
          style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        Spacer(),
        SizedBox(
            width: SizeConfig.screenWidth * 0.6,
            child: DefaultButton(
              text: "Đến trang chính",
              press: () {
                Navigator.popAndPushNamed(context, HomeScreen.routeName);
              },
            )),
        Spacer(),
      ]),
    );
  }
}
