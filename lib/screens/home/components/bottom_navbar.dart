import 'package:chocaycanh/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
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
              svgScr: "assets/icons/Shop Icon.svg",
              isActive: true,
            ),
            BottomNavItem(
              title: "Tìm kiếm",
              svgScr: "assets/icons/search.svg",
              isActive: false,
            ),
            BottomNavItem(
              title: "Mua",
              svgScr: "assets/icons/bag.svg",
              isActive: false,
            ),
            BottomNavItem(
              title: "Tôi",
              svgScr: "assets/icons/User Icon.svg",
              isActive: false,
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
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
