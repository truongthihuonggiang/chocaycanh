import 'package:flutter/material.dart';
import 'package:chocaycanh/size_config.dart';

// const linkRegister = "http://10.0.2.2/vanguard/public/api/register";
// const linkLogin = "http://10.0.2.2/vanguard/public/api/login";
// const linkLoginSocial = "http://10.0.2.2/vanguard/public/api/login/social";

const linkRegister = "https://cuoituan.vn/longgym/api/register";
const linkLogin = "https://cuoituan.vn/longgym/api/login";
const linkLoginSocial = "https://cuoituan.vn/longgym/api/login/social";

const kSuccessColor = Color(0xAA0C9800);
const kPrimaryColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);

const double kDefaultPadding = 20.0;

//const kTextColor = Color(0xFF757575);
//const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft, end: Alignment.bottomRight,
  colors: [const Color(0xffee0000), const Color(0xffeeee00)], // red to yellow
);
const kSecondaryColor = Color(0xFF979797);

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
const String kEmailNullError = "Xin hãy điền thông tin email";
const String kInvalidEmailError = "Xin hãy điền email hợp lệ";
const String kPassNullError = "Xin hãy điền mật khẩu";
const String kShortPassError = "Mật khẩu quá ngắn";
const String kMatchPassError = "Mật khẩu không giống nhau";
const String kNamelNullError = "Xin hãy điền tên";
const String kPhoneNumberNullError = "Xin hãy điền số ddieenj thoại";
const String kAddressNullError = "Xin hãy điền địa chỉ";

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
