import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chocaycanh/components/default_button.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/model/User.dart';
import 'package:chocaycanh/profile.dart';
import 'package:chocaycanh/screens/home/home_screen.dart';
import 'package:chocaycanh/screens/sign_in/sign_in_screen.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:chocaycanh/token.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'splash_content.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Chào mừng đến trung tâm cây cảnh!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text": "Chúng tôi kết nối với các nhà vườn trên toàn quốc",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "Chúng tôi mang đến sự yên tâm và hài lòng",
      "image": "assets/images/splash_3.png"
    }
  ];
  @override
  Widget build(BuildContext context) {
    checklogin();
    // TODO: implement build
    return SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => SplashContent(
                      image: splashData[index]["image"],
                      text: splashData[index]["text"],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Column(
                      children: [
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(splashData.length,
                              (index) => buildDot(index: index)),
                        ),
                        Spacer(
                          flex: 3,
                        ),
                        // DefaultButton(
                        //   text: "Tiếp tục",
                        //   press: () {
                        //     Navigator.popAndPushNamed(
                        //         context, SignInScreen.routeName);
                        //   },
                        // ),
                        // Spacer(),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  Future<Token> checklogin() async {
    final prefs = await SharedPreferences.getInstance();
    final String myUsername = prefs.getString('username') ?? "";
    final String myPass = prefs.getString('password') ?? "";
    final String myToken = prefs.getString('token') ?? "";
    debugPrint("token:" + myToken);
    if (myToken != "") {
      Token.token = myToken;

      getprofile();
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => SignInScreen())));
    }
  }

  Future<User> getprofile() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    var response = await http.get(
      linkprofile,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + ' ' + Token.token,
      },
    );

    debugPrint('trong phuong thuc get profile sign form');
    debugPrint('statuscode:' + response.statusCode.toString());
    if (response.statusCode == 200) {
      ////////////
      var data = json.decode(response.body);
      var users = data['data'];
      var user = User.fromJson(users);
      var profile = Myprofile.fromUser(user);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('username', user.username);
      prefs.setString('email', user.email);
      prefs.setString('avatar', user.avatar);
      prefs.setString('first_name', user.first_name);
      prefs.setString('last_name', user.last_name);
      prefs.setInt('id', user.id);
      prefs.setInt('role_id', user.role_id);
      debugPrint('avatar' + user.avatar);
      Navigator.popAndPushNamed(context, HomeScreen.routeName);
      return user;
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => SignInScreen())));
    }
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: index == currentPage ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
