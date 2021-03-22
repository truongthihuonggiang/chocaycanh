import 'package:chocaycanh/components/draweritem.dart';

import 'package:chocaycanh/screens/profilescreen/profile_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class Menuitem {
  IconData icon;
  String title;
  Function press;
  bool isActive;
  Menuitem({this.icon, this.title, this.press, this.isActive});
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<Menuitem> dsmenu = new List();

  final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  void initState() {
    super.initState();
    dsmenu.add(new Menuitem(
        icon: Icons.home_filled,
        title: "trang chủ",
        isActive: true,
        press: () {
          for (var i = 0; i < dsmenu.length; i++) {
            if (dsmenu[i].title == "trang chủ") {
              setState(() {
                dsmenu[i].isActive = true;
              });
            } else {
              setState(() {
                dsmenu[i].isActive = false;
              });
            }
          }
        }));
    dsmenu.add(new Menuitem(
        icon: Icons.account_box_sharp,
        title: "hồ sơ",
        isActive: false,
        press: () {
          for (var i = 0; i < dsmenu.length; i++) {
            if (dsmenu[i].title == "hồ sơ") {
              setState(() {
                dsmenu[i].isActive = true;
              });
            } else {
              setState(() {
                dsmenu[i].isActive = false;
              });
            }
          }
          //  Navigator.pop(context);
          Navigator.popAndPushNamed(context, ProfileScreen.routeName);
        }));
    //
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: _scaffoldKey,
      children: List.generate(
        dsmenu.length,
        (index) => Draweritem(
            icon: dsmenu[index].icon,
            title: dsmenu[index].title,
            press: dsmenu[index].press,
            isActive: dsmenu[index].isActive),
      ),
    );
  }
}
