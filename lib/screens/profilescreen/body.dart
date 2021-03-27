import 'package:chocaycanh/model/User.dart';
import 'package:chocaycanh/screens/complete_profile/complete_profile_screen.dart';
import 'package:chocaycanh/screens/profilescreen/detail_interface.dart';
import 'package:chocaycanh/screens/profilescreen/resetpassword.dart';
import 'package:chocaycanh/services/service_getprofile.dart';
import 'package:flutter/material.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/size_config.dart';

import '../../profile.dart';
import 'profile_avatar.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildClipPath(),
            DetailProfile(),
          ],
        ),
      ),
    );
  }

  ClipPath buildClipPath() {
    return ClipPath(
      clipper: MyProfileClipper(),
      child: Container(
          padding: EdgeInsets.only(top: getProportionateScreenWidth(10)),
          height: getProportionateScreenHeight(200),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [kSuccessColor, kPrimaryColor]),
          ),
          child: ProfileAvatar()),
    );
  }
}

class DetailProfile extends StatefulWidget {
  @override
  _DetailProfileState createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile>
    implements Detail_interface {
  String firstName = Myprofile.first_name == null ? '' : Myprofile.first_name;
  String lastName = Myprofile.last_name == null ? '' : Myprofile.last_name;
  String phone = Myprofile.phone == null ? '' : Myprofile.phone;
  String address = Myprofile.address == null ? '' : Myprofile.address;
  String email = Myprofile.email == null ? '' : Myprofile.address;
  final GlobalKey _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // updatelogin();

    return Container(
      key: _scaffoldKey,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          FutureBuilder(
            future: updatelogin(),
            builder: (context, snapshot) => snapshot.hasData
                ? buildDetail(
                    snapshot.data,
                  )
                : Center(child: Image.asset("assets/images/ripple.gif")),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Điều chỉnh thông tin',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CompleteProfileScreen(callback: this)));
            },
          ),
        ],
      ),
    );
  }

  Column buildDetail(User user) {
    this.email = user.email == null ? "chưa có thông tin" : user.email;
    this.phone = user.phone == null ? "chưa có thông tin" : user.phone;
    this.address = user.address == null ? "chưa có thông tin" : user.address;
    this.firstName =
        user.address == null ? "chưa có thông tin" : user.first_name;
    this.lastName = user.address == null ? "chưa có thông tin" : user.last_name;

    return Column(
      children: [
        buildInfoRow(Icons.account_box, "tên", '$firstName $lastName'),
        buildInfoRow(Icons.phone_android, "Điện thoại", phone),
        buildInfoRow(Icons.email, "Email", email),
        buildInfoRow(Icons.place, "Địa chỉ", address),
        buildPasswordRow(),
      ],
    );
  }

  Row buildInfoRow(IconData icon, String title, String content) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          child: Container(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(10)),
            child: Icon(
              icon,
              color: Colors.green,
              size: 30.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: subheadtextstyle,
              ),
              Text(content)
            ],
          ),
        )
      ],
    );
  }

  Row buildPasswordRow() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          child: Container(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(10)),
            child: Icon(
              Icons.keyboard,
              color: Colors.green,
              size: 30.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mật khẩu',
                style: subheadtextstyle,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Resetpassword.routeName);
                  },
                  child: Text('đổi mật khẩu'))
            ],
          ),
        )
      ],
    );
  }

  @override
  void updateDetail(User user) {
    debugPrint('update detail body profilescreen');

    setState(() {
      this.email = user.email == null ? "chưa có thông tin" : user.email;
      this.phone = user.phone == null ? "chưa có thông tin" : user.phone;
      this.address = user.address == null ? "chưa có thông tin" : user.address;
      this.firstName =
          user.address == null ? "chưa có thông tin" : user.first_name;
      this.lastName =
          user.address == null ? "chưa có thông tin" : user.last_name;
    });
  }
}

class MyProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
