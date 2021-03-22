import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/model/products.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/body.dart';

class DetailProductScreen extends StatelessWidget {
  final Product product;
  static String routeName = "/productdetail";
  const DetailProductScreen({Key key, @required this.product})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kshopbackColor,
      appBar: buildAppBar(context),
      body: Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/arrow-long-left.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/bag.svg"),
          onPressed: () {},
        ),
        SizedBox(width: SizeConfig.defaultSize),
      ],
    );
  }
}
