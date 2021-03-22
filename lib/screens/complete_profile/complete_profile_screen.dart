import 'package:chocaycanh/screens/profilescreen/detail_interface.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  final Detail_interface callback;

  const CompleteProfileScreen({Key key, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hoàn thiện hồ sơ"),
      ),
      body: Body(
        callback: callback,
      ),
    );
  }
}
