import 'package:chocaycanh/components/customdrawer.dart';

import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/model/User.dart';
import 'package:chocaycanh/profile.dart';
import 'package:chocaycanh/screens/cart/cart_screen.dart';
import 'package:chocaycanh/screens/sign_in/sign_in_screen.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:chocaycanh/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/body.dart';
import '../../components/bottom_navbar.dart';
import '../profilescreen/profile_avatar.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey _scaffoldKey = new GlobalKey();
  double defaultSize = SizeConfig.defaultSize;
  static String routeName = "/homepage";
  static String avatarstr = "";
  Widget avatar;
  @override
  Widget build(BuildContext context) {
    // var press4 = () {
    //   print('bam cua toi');
    //   //  Navigator.popAndPushNamed(context, CuahangScreen.routeName);
    //   Navigator.of(context).pushReplacement(PageRouteBuilder(
    //       pageBuilder: (context, animation, secondaryAnimation) =>
    //           CuahangScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return child;
    //       }));
    // };
    var press1 = () {
      LinkHome(context);
    };
    var press4 = () {
      LinkStore(context);
    };
    var press2 = () {
      LinkHome(context);
    };
    var press3 = () {
      Navigator.pushNamed(context, CartScreen.routeName);
    };
    getprofile();
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      drawer: buildDrawer(context),
      body: Body(),
      bottomNavigationBar: BottomNavBar(
        press1: press1,
        press2: press2,
        press3: press3,
        press4: press4,
        numberActive: 0,
      ),
    );
  }

  Future<Widget> getprofile() async {
    final prefs = await SharedPreferences.getInstance();
    final String myUsername = prefs.getString('username') ?? "";
    Token.token = prefs.getString('token') ?? "";
    final String last_name = prefs.getString('last_name') ?? "";
    final String first_name = prefs.getString('first_name') ?? "";
    final String email = prefs.getString('email') ?? "";
    final String phone = prefs.getString('phone') ?? "";
    final String address = prefs.getString('address') ?? "";
    final int role_id =
        prefs.getInt('role_id') == null ? "" : prefs.getInt('role_id');
    final int id = prefs.getInt('id') ?? "";
    avatarstr = prefs.getString('avatar') ?? "";
    Myprofile.address = address;
    Myprofile.avatar = avatarstr;
    Myprofile.username = myUsername;
    Myprofile.first_name = first_name;
    Myprofile.last_name = last_name;
    Myprofile.email = email;
    Myprofile.phone = phone;
    Myprofile.role_id = role_id;
    debugPrint('avatar:' + avatarstr);
  }

  Future<User> logout(context) async {
    final prefs = await SharedPreferences.getInstance();
    Token.token = "";
    prefs.setString('token', '');
    // Navigator.popAndPushNamed(context, SignInScreen.routeName);
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => SignInScreen(),
      ),
      (route) => false, //if you want to disable back feature set to false
    );
  }

  //RotateWidget(child: avatar))
  Drawer buildDrawer(BuildContext context) {
    return new Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: getProportionateScreenHeight(210),
                child: DrawerHeader(
                  child: ProfileAvatar(),
                ),
              ),
              CustomDrawer(),
            ],
          ),
          Column(
            children: [
              const Divider(
                height: 20,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                title: Text(
                  'Sign Out',
                  textAlign: TextAlign.left,
                ),
                leading: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  logout(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/scan.svg",
              height: (SizeConfig.defaultSize * 2.4)),
          onPressed: () {},
        ),
        Center(
          child: Text(
            'quét',
            style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: SizeConfig.defaultSize),
      ],
    );
  }
}
