import 'package:chocaycanh/constants.dart';

import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

import 'complete_profile_form.dart';

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
              Text("Hoàn thiện hồ sơ", style: headingStyle),
              Text(
                "Điền các thông tin chi tiết \ncho tài khoản của bạn",
                textAlign: TextAlign.center,
              ),
              CompleteProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
