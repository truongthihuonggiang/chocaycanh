import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

class Draweritem extends StatelessWidget {
  final GlobalKey _scaffoldKey = new GlobalKey();
  Draweritem({
    this.press,
    this.title,
    this.isActive = false,
    this.icon = Icons.ac_unit_outlined,
  });
  final String title;
  final Function press;
  final bool isActive;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return InkWell(
      key: _scaffoldKey,
      splashColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.transparent,
      onTap: press,
      child: Container(
        height: 46,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        decoration: isActive
            ? BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(28),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(28),
                ),
              )
            : null,
        child: Padding(
          padding: EdgeInsets.only(
              left: getProportionateScreenWidth(0),
              right: getProportionateScreenWidth(0)),
          //    child: Text(title),
          child: ListTile(
            title: Text(
              title,
              textAlign: TextAlign.left,
            ),
            leading: Icon(
              icon,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
