import 'package:chocaycanh/screens/cuahang/cuahang_screen.dart';
import 'package:chocaycanh/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:chocaycanh/size_config.dart';

import 'model/Store.dart';
import 'screens/storedetail/store_detail.dart';
import 'services/fetchStore.dart';

// const linkRegister = "http://10.0.2.2/vanguard/public/api/register";
// const linkLogin = "http://10.0.2.2/vanguard/public/api/login";
// const linkLoginSocial = "http://10.0.2.2/vanguard/public/api/login/social";

const linkRegister = "https://chocaycanh.club/api/register";
const linkLogin = "https://chocaycanh.club/api/login";
const linkLoginSocial = "https://chocaycanh.club/api/login/social";
const linkprofile = "https://chocaycanh.club/api/me";
const linkuploadavatar = "https://chocaycanh.club/api/me/avatar";
const linkupdatedetail = "https://chocaycanh.club/api/me/details";
const linkupdateauth = "https://chocaycanh.club/api/me/details/auth";
const kSuccessColor = Color(0xAA0C9800);
const kPrimaryColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);

const double kDefaultPadding = 20.0;
const kInactiveIconcolor = Color(0xFF979797);
const kActiveIconcolor = Color(0xFFFF7643);
//const kTextColor = Color(0xFF757575);
//const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft, end: Alignment.bottomRight,
  colors: [const Color(0xffee0000), const Color(0xffeeee00)], // red to yellow
);
const kSecondaryColor = Color(0xFF979797);
const kshopbackColor = Color(0xFFF3F6F8);
const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Xin h??y ??i???n th??ng tin email";
const String kInvalidEmailError = "Xin h??y ??i???n email h???p l???";
const String kPassNullError = "Xin h??y ??i???n m???t kh???u";
const String kShortPassError = "M???t kh???u qu?? ng???n";
const String kMatchPassError = "M???t kh???u kh??ng gi???ng nhau";
const String kNamelNullError = "Xin h??y ??i???n t??n";
const String kPhoneNumberNullError = "Xin h??y ??i???n s??? ??i???n tho???i";
const String kAddressNullError = "Xin h??y ??i???n ?????a ch???";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

final pricetext = TextStyle(
  fontWeight: FontWeight.bold,
);
final striketext =
    TextStyle(color: kSecondaryColor, decoration: TextDecoration.lineThrough);
final superwhiteheadtextstyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
final superstrokeheadtextstyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  foreground: Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 6
    ..color = Colors.black87,
  //color: Colors.white,
);
final subwhiteheadtextstyle = TextStyle(
  fontSize: getProportionateScreenWidth(16),
  fontWeight: FontWeight.bold,
  //color: Colors.white,
  foreground: Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 6
    ..color = Colors.black87,
);
final headtextstyle = TextStyle(
  fontSize: getProportionateScreenWidth(18),
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);
final subheadtextstyle = TextStyle(
  fontSize: getProportionateScreenWidth(16),
  fontWeight: FontWeight.bold,
  color: kTextColor,
);
final lighttextstyle = TextStyle(color: kTextColor.withOpacity(0.6));
final textlink = TextStyle(color: kPrimaryColor.withOpacity(0.6));
String format(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
}

void LinkHome(context) {
  //   Navigator.popAndPushNamed(context, HomeScreen.routeName);
  print('bam cua toi');
  //  Navigator.popAndPushNamed(context, CuahangScreen.routeName);
  Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      }));
}

void LinkStore(context) {
  //   Navigator.popAndPushNamed(context, HomeScreen.routeName);
  print('bam cua toi');
  //  Navigator.popAndPushNamed(context, CuahangScreen.routeName);
  Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CuahangScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      }));
}

Future<void> storeNav(BuildContext context, int id) async {
  Store store = await getStore(id);

  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => DetailStoreScreen(store: store)));
}
