import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/model/Store.dart';

import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/boby.dart';

class DetailStoreScreen extends StatelessWidget {
  final Store store;
  static String routeName = "/storedetail";
  const DetailStoreScreen({Key key, @required this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kshopbackColor,
      //    extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: Body(store: store),
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
