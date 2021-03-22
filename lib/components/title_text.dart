import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

class HeadText extends StatelessWidget {
  final String title;
  const HeadText({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Padding(
        padding: EdgeInsets.all(defaultSize * 2),
        child: Text(
          title,
          style: headtextstyle,
        ));
  }
}

class TitleText extends StatelessWidget {
  final String title;
  const TitleText({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Text(
      title,
      style: headtextstyle,
    );
  }
}
