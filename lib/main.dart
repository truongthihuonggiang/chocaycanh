import 'package:chocaycanh/screens/complete_profile/complete_profile_screen.dart';
import 'package:chocaycanh/screens/splash/splash_screen.dart';
import 'package:chocaycanh/theme.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: CompleteProfileScreen(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
