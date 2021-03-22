import 'dart:convert';

import 'package:chocaycanh/components/social_card.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/screens/EmailConform/email_conform.dart';
import 'package:chocaycanh/screens/login_success/login_success_screen.dart';
import 'package:chocaycanh/screens/sign_in/components/sign_form.dart';

import 'package:chocaycanh/size_config.dart';
import 'package:chocaycanh/token.dart';
import 'package:flutter/material.dart';
import 'package:http_logger/log_level.dart';
import 'package:http_logger/logging_middleware.dart';
import 'package:http_middleware/http_with_middleware.dart';
import 'no_account_text.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                Text(
                  "Chào bạn quay trở lại",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Đăng nhập bằng tên và email \nhoặc bằng tài khoản mạng xã hội",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                SignForm(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GoogleCard(),
                    FacebookCard(),
                    AplleCard(),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                NoAccountText()
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class AplleCard extends StatefulWidget {
  @override
  _AplleCardState createState() => _AplleCardState();
}

class _AplleCardState extends State<AplleCard> {
  @override
  Widget build(BuildContext context) {
    return SocialCard(
      icon: "assets/icons/twitter.svg",
      press: () {
        _loginapple();
      },
    );
  }

  _loginapple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    print(credential);
    print(credential.authorizationCode);
    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
  }
}

class GoogleCard extends StatefulWidget {
  @override
  _GoogleCardState createState() => _GoogleCardState();
}

class _GoogleCardState extends State<GoogleCard> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool _isLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return SocialCard(
      icon: "assets/icons/google-icon.svg",
      press: () {
        _logingg();
      },
    );
  }

  _logingg() async {
    try {
      GoogleSignInAccount user = await _googleSignIn.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await user.authentication;

      print(googleSignInAuthentication.accessToken);
      String token = googleSignInAuthentication.accessToken;
      postGoogleSignup(token);
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err) {
      print(err);
    }
  }

  _logoutgg() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  Future<void> postGoogleSignup(String token) async {
    HttpWithMiddleware httpClient = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    String devicename = "app";
    final http.Response response = await httpClient.post(
      linkLoginSocial,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "network": "google",
        "social_token": token,
        "device_name": devicename
      }),
    );

    debugPrint('trong phuong thuc facebook dang nhap');

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      if (jsonDecode(response.body)['requires_email_confirmation'] != null) {
        var requires_email_confirmation =
            jsonDecode(response.body)['requires_email_confirmation'];
        if (requires_email_confirmation == true) {
          Navigator.popAndPushNamed(context, EmailConformScreen.routeName);
        }
      } else {
        Token.token = jsonDecode(response.body)['token'];
        Navigator.popAndPushNamed(context, LoginSuccessScreen.routeName);
      }
    } else {
      if (response.statusCode == 422) {
        var mess = json.decode(response.body);
        var m_errors = mess['errors'];
      } else {
        throw Exception('Không xác định lỗi trong đăng ký');
      }
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

    }
  }
}

class FacebookCard extends StatefulWidget {
  @override
  _FacebookCardState createState() => _FacebookCardState();
}

class _FacebookCardState extends State<FacebookCard> {
  bool _isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  @override
  Widget build(BuildContext context) {
    return SocialCard(
      icon: "assets/icons/facebook-2.svg",
      press: () {
        debugPrint('trong phuong press');
        _loginWithFB();
      },
    );
  }

  _loginWithFB() async {
    debugPrint('trong phuong press1');
    //final result = await facebookLogin.logInWithReadPermissions(['email']);
    final result = await facebookLogin.logIn(['email', 'public_profile']);
    debugPrint('trong phuong press2');
    debugPrint(result.status.toString());
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
        });
        postFaceSignup(token);
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false);
        break;
    }
  }

  _logout() {
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  Future<void> postFaceSignup(String token) async {
    HttpWithMiddleware httpClient = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    String devicename = "app";
    final http.Response response = await httpClient.post(
      linkLoginSocial,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "network": "facebook",
        "social_token": token,
        "device_name": devicename
      }),
    );

    debugPrint('trong phuong thuc facebook dang nhap');

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      if (jsonDecode(response.body)['requires_email_confirmation'] != null) {
        var requires_email_confirmation =
            jsonDecode(response.body)['requires_email_confirmation'];
        if (requires_email_confirmation == true) {
          Navigator.popAndPushNamed(context, EmailConformScreen.routeName);
        }
      } else {
        Token.token = jsonDecode(response.body)['token'];
        Navigator.popAndPushNamed(context, LoginSuccessScreen.routeName);
      }
    } else {
      if (response.statusCode == 422) {
        var mess = json.decode(response.body);
        var m_errors = mess['errors'];
      } else {
        throw Exception('Không xác định lỗi trong đăng ký');
      }
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

    }
  }
}
