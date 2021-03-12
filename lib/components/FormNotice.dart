import 'package:chocaycanh/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size_config.dart';

class FormNotice extends StatelessWidget {
  const FormNotice({
    Key key,
    this.messages,
  }) : super(key: key);
  final List<String> messages;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          messages.length, (index) => formErrorText(mess: messages[index])),
    );
  }

  Container formErrorText({String mess}) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        child: Container(
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/Bell.svg",
                height: getProportionateScreenHeight(14),
                width: getProportionateScreenWidth(14),
              ),
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              Flexible(
                  child: Text(
                mess,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: kSuccessColor),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
