import 'package:chocaycanh/screens/EmailConform/email_conform.dart';
import 'package:chocaycanh/screens/complete_profile/complete_profile_screen.dart';
import 'package:chocaycanh/screens/forgot_password/forgot_password.dart';
import 'package:chocaycanh/screens/login_success/login_success_screen.dart';
import 'package:chocaycanh/screens/sign_in/sign_in_screen.dart';
import 'package:chocaycanh/screens/sign_up/sign_up_screen.dart';
import 'package:chocaycanh/screens/splash/splash_screen.dart';

import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  EmailConformScreen.routeName: (context) => EmailConformScreen(),
};
