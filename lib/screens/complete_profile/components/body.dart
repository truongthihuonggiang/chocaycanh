import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/screens/profilescreen/detail_interface.dart';

import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  final Detail_interface callback;

  const Body({Key key, this.callback}) : super(key: key);
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
              CompleteProfileForm(
                callback: callback,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
