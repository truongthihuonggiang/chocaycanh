import 'dart:io';

import 'package:chocaycanh/components/default_button.dart';
import 'package:chocaycanh/components/dropdown.dart';
import 'package:chocaycanh/components/dropdownhuyen.dart';
import 'package:chocaycanh/components/form_error.dart';
import 'package:chocaycanh/constants.dart';

import 'package:chocaycanh/screens/profilescreen/detail_interface.dart';
import 'package:chocaycanh/screens/profilescreen/profile_screen.dart';
import 'package:chocaycanh/screens/sign_in/components/custom_surfix_icon.dart';
import 'package:chocaycanh/services/fetchAddress.dart';
import 'package:chocaycanh/services/service_getprofile.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:chocaycanh/token.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../../token.dart';
import 'dart:convert';
import '../../../profile.dart';

class CompleteProfileForm extends StatefulWidget {
  final Detail_interface callback;

  const CompleteProfileForm({Key key, this.callback}) : super(key: key);
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formkey = GlobalKey<FormState>();
  String firstName = Myprofile.first_name == null ? '' : Myprofile.first_name;
  String lastName = Myprofile.last_name == null ? '' : Myprofile.last_name;
  String phoneNumber = Myprofile.phone == null ? '' : Myprofile.phone;
  String address = Myprofile.address == null ? '' : Myprofile.address;
  String email;
  String fulladress = "";
  List<Diadiem> lsTinh = new List();
  List<Diadiem> lsHuyen = new List();
  List<Diadiem> lsXa = new List();
  Diadiem _selectTinh, _selectHuyen, _selectXa;
  DropDownhuyen tpwidget = null;
  Widget xawidget = null;
  bool isloading = true;
  final List<String> errors = [];
  void addError({String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    lsTinh.add(new Diadiem(id: 1, ten: "giang"));

    firstName = Myprofile.first_name == null ? '' : Myprofile.first_name;
    lastName = Myprofile.last_name == null ? '' : Myprofile.last_name;
    address = Myprofile.address == null ? '' : Myprofile.address;
    phoneNumber = Myprofile.phone == null ? '' : Myprofile.phone;
    email = Myprofile.phone == null ? '' : Myprofile.email;
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFirstNameFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildLastNameFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildPhoneNumberFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildAddressFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Text('Chọn tỉnh/huyện/xã'),
          Container(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTInh(),
                Text('Chọn huyện/tp'),
                tpwidget == null
                    ? Text(
                        'chưa có dữ liệu',
                        style: lighttextstyle,
                      )
                    : tpwidget,
                Text('Chọn xã/phường'),
                xawidget == null
                    ? Text('chưa có dữ liệu', style: lighttextstyle)
                    : xawidget,
              ],
            ),
          ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          DefaultButton(
            text: "Lưu",
            press: () async {
              if (_formkey.currentState.validate()) {
                await postdetail();

                //    Navigator.pop(context);
              }
            },
          ),
          SizedBox(
            height:
                getProportionateScreenHeight(SizeConfig.screenHeight * 0.02),
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<Diadiem>> buildTInh() {
    return FutureBuilder(
      future: fetchTinh(),
      builder: (context, snapshot) => snapshot.hasData
          ? DropDown(
              snapshot.data,
              onChanged: (value) {
                _selectTinh = value;
                print('tentinh:' + _selectTinh.ten);
                buildHuyen1();
                //  tpwidget = new Container();
                // var temp = buildHuyen();
                // print(temp);
                setState(() {
                  tpwidget = null;
                });
                //    tpwidget = temp;
              },
            )
          : Center(child: Image.asset("assets/images/ripple.gif")),
    );
  }

  void buildHuyen1() async {
    lsHuyen = await Diadiem.fetchHuyen(_selectTinh.id);

    //(DropDownhuyen) tpwidget as DropDownhuyen

    setState(() {
      // tpwidget = Container(child: Text('lan' + lsHuyen[0].ten));
      tpwidget = DropDownhuyen(
        lsHuyen,
        onChanged: (value) {
          _selectHuyen = value;
          print('ten huyen:' + _selectHuyen.ten);
          buildXa1();
          setState(() {
            xawidget = null;
          });
        },
      );
    });

    //print(tpwidget);
  }

  // FutureBuilder<List<Diadiem>> buildHuyen() {
  //   return FutureBuilder(
  //     future: Diadiem.fetchHuyen(_selectTinh.id),
  //     builder: (context, snapshot) => snapshot.hasData
  //         ? DropDown(
  //             snapshot.data,
  //             onChanged: (value) {
  //               _selectHuyen = value;
  //               print('ten huyen:' + _selectHuyen.ten);
  //               setState(() {
  //                 xawidget = null;
  //               });
  //               buildXa1();
  //             },
  //           )
  //         : Center(child: Image.asset("assets/images/ripple.gif")),
  //   );
  // }

  void buildXa1() async {
    lsXa = await fetchXa(_selectHuyen.id);

    //(DropDownhuyen) tpwidget as DropDownhuyen

    setState(() {
      // tpwidget = Container(child: Text('lan' + lsHuyen[0].ten));
      xawidget = DropDownhuyen(
        lsXa,
        onChanged: (value) {
          _selectXa = value;
          print('tenxa:' + _selectXa.ten);
        },
      );
    });
  }

  // FutureBuilder<List<Diadiem>> buildXa() {
  //   return FutureBuilder(
  //     future: fetchXa(_selectHuyen.id),
  //     builder: (context, snapshot) => snapshot.hasData
  //         ? DropDown(
  //             snapshot.data,
  //             onChanged: (value) {
  //               _selectXa = value;
  //               print('tenxa:' + _selectXa.ten);
  //             },
  //           )
  //         : Center(child: Image.asset("assets/images/ripple.gif")),
  //   );
  // }

  Future<void> postdetail() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    String devicename = "app";
    fulladress = address +
        ' ' +
        _selectXa.ten +
        ' ' +
        _selectHuyen.ten +
        ' ' +
        _selectTinh.ten;
    print('fulladdress' + fulladress);
    print('address' + address);
    print('phone' + phoneNumber);
//  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
    // devicename = androidInfo.model.toString();
    // //IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // //print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
    // //devicename = devicename + iosInfo.utsname.machine.toString();
    print('api' + linkupdatedetail);
    final http.Response response = await http.patch(
      linkupdatedetail,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + ' ' + Token.token,
      },
      body: jsonEncode(<String, String>{
        'first_name': firstName,
        'last_name': lastName,
        'phone': phoneNumber,
        'address': fulladress,
        'provinceid': _selectTinh.id.toString(),
        'provincename': _selectTinh.ten,
        'districtid': _selectHuyen.id.toString(),
        'districtname': _selectHuyen.ten,
        'wardid': _selectXa.id.toString(),
        'wardname': _selectXa.ten,
        'street': address,
      }),
    );
    print('statuscode' + response.statusCode.toString());
    print('body' + response.body);
    if (response.statusCode == 200) {
      widget.callback.updateDetail(await updatelogin());
    } else {
      var mess = json.decode(response.body);
      var m_errors = mess['errors'];
      errors.clear();
      if (response.statusCode == 401) {
        if (mess['message'] != null && !errors.contains(mess['message'])) {
          setState(() {
            errors.add(mess['message']);
          });
        }
      } else {
        if (response.statusCode == 422) {
          if (m_errors['username'] != null &&
              !errors.contains(m_errors['username'][0])) {
            setState(() {
              errors.add(m_errors['username'][0]);
            });
          }
        } else {}
      }
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

    }
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      initialValue: address,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        address = value;
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Số nhà và đường",
        hintText: "Điền địa chỉ của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Location point.svg",
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      initialValue: phoneNumber,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        phoneNumber = value;
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Số điện thoại",
        hintText: "Điền số điện thoại của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Phone.svg",
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      initialValue: lastName,
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) => lastName = value,
      decoration: InputDecoration(
        labelText: "Tên",
        hintText: "Điền tên của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      initialValue: firstName,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        firstName = value;
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Họ",
        hintText: "Điền họ của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }
}
