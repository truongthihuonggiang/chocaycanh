import 'package:chocaycanh/components/default_button.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/screens/sign_in/sign_in_screen.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

import 'splash_content.dart';

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
                        DefaultButton(
                          text: "Tiếp tục",
                          press: () {
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                          },
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                )
              ],
            )));
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
