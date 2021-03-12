import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    this.errors,
  }) : super(key: key);
  final List<String> errors;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({String error}) {
    return Row(
      children: [
        Container(
          width: getProportionateScreenWidth(20),
          child: SvgPicture.asset(
            "assets/icons/Error.svg",
            height: getProportionateScreenHeight(14),
            width: getProportionateScreenWidth(14),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Flexible(child: Text(error)),
      ],
    );
  }
}
