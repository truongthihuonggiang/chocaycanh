import 'package:chocaycanh/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final Function press1, press2, press3, press4;
  final int numberActive;
  const BottomNavBar({
    Key key,
    this.press1,
    this.press2,
    this.press3,
    this.press4,
    this.numberActive = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 65,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavItem(
              title: "Chợ",
              svgScr: "assets/icons/receipt.svg",
              isActive: numberActive == 0 ? true : false,
              press: press1,
            ),
            BottomNavItem(
              title: "Tìm kiếm",
              svgScr: "assets/icons/search.svg",
              isActive: numberActive == 1 ? true : false,
              press: press2,
            ),
            BottomNavItem(
              title: "Mua",
              svgScr: "assets/icons/bag.svg",
              isActive: numberActive == 2 ? true : false,
              press: press3,
            ),
            BottomNavItem(
              title: "Cửa hàng",
              svgScr: "assets/icons/Shop Icon.svg",
              isActive: numberActive == 3 ? true : false,
              press: press4,
            ),
          ],
        ));
  }
}

class BottomNavItem extends StatelessWidget {
  final String svgScr;
  final String title;
  final Function press;
  final bool isActive;
  const BottomNavItem({
    Key key,
    this.svgScr,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(svgScr,
              color: isActive ? kActiveIconcolor : kInactiveIconcolor),
          Text(title,
              style: TextStyle(
                  color: isActive ? kActiveIconcolor : kInactiveIconcolor)),
        ],
      ),
    );
  }
}
