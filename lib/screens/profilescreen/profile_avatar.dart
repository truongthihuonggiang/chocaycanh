import 'package:chocaycanh/components/rotatewidget.dart';
import 'package:chocaycanh/constants.dart';

import 'package:chocaycanh/profile.dart';
import 'package:chocaycanh/screens/profilescreen/upload_avatar.dart';
import 'package:chocaycanh/screens/profilescreen/avatar_interface.dart';
import 'package:chocaycanh/services/service_getprofile.dart';
import 'package:chocaycanh/size_config.dart';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatefulWidget {
  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar>
    implements Avatar_interface {
  final GlobalKey _scaffoldKey = new GlobalKey();
  String avatarstr = Myprofile.avatar;
  String firstname = '';
  String lastname = '';
  String fullname = '';
  @override
  void initState() {
    super.initState();
    //  getprofile();
  }

  @override
  void updateAvatar(BuildContext context) {
    setState(() {
      avatarstr = Myprofile.avatar;
      firstname = Myprofile.first_name == null ? '' : Myprofile.first_name;
      lastname = Myprofile.last_name == null ? '' : Myprofile.last_name;
      fullname = Myprofile.username == null ? '' : Myprofile.username;
      ;
    });
    // TODO: implement updateAvatar
  }

  @override
  Widget build(BuildContext context) {
    updatelogin();

    fullname = Myprofile.username == null ? '' : Myprofile.username;

    return Column(
      key: _scaffoldKey,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
                padding:
                    EdgeInsets.only(bottom: getProportionateScreenHeight(40)),
                child: getavatar(avatarstr)),
            IconButton(
              icon: const Icon(Icons.photo_camera),
              tooltip: 'Đổi avatar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UploadAvartar(callback: this)),
                );
              },
            ),
          ],
        ),
        Text('Xin chào $fullname'),
      ],
    );
  }

  RotateWidget getavatar(String avatarstr) {
    debugPrint('avatar:' + avatarstr);
    debugPrint('fullname:' + fullname);
    var avatar = RotateWidget(
      height: getProportionateScreenHeight(80),
      width: getProportionateScreenHeight(80),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: kshopbackColor.withOpacity(0.6),
                offset: const Offset(2.0, 4.0),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/spinner.gif",
              image: avatarstr,
              fit: BoxFit.cover,
            )),
      ),
    );
    return avatar;
  }
}
