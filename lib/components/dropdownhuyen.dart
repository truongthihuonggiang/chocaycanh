import 'package:chocaycanh/services/fetchAddress.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DropDownhuyen extends StatefulWidget {
  List<Diadiem> _companies;
  Function onChanged;
  DropDownhuyenState state;
  DropDownhuyen(this._companies, {this.onChanged}) : super();

  final String title = "DropDown Demo";

  @override
  DropDownhuyenState createState() {
    this.state = new DropDownhuyenState();

    return this.state;
  }
}

class DropDownhuyenState extends State<DropDownhuyen> {
  //
  final GlobalKey _scaffoldKey = new GlobalKey();
  void updateList(List<Diadiem> ls) {
    setState(() {
      widget._companies.clear();

      widget._companies.addAll(ls);
    });
  }

  List<DropdownMenuItem<Diadiem>> _dropdownMenuItems;
  Diadiem _selectedDiadiem;

  DropDownhuyenState();

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(widget._companies);
    _selectedDiadiem = _dropdownMenuItems[0].value;

    super.initState();
  }

  List<DropdownMenuItem<Diadiem>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Diadiem>> items = List();
    for (Diadiem diadiem in companies) {
      items.add(
        DropdownMenuItem(
          value: diadiem,
          child: Text(diadiem.ten),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Diadiem selectedDiadiem) {
    setState(() {
      _selectedDiadiem = selectedDiadiem;
      widget.onChanged(_selectedDiadiem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: _scaffoldKey,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: double.infinity,
          //  height: 50.0,
          padding: EdgeInsets.only(
              left:
                  getProportionateScreenWidth(getProportionateScreenWidth(28)),
              top: getProportionateScreenWidth(getProportionateScreenWidth(10)),
              bottom:
                  getProportionateScreenWidth(getProportionateScreenWidth(5)),
              right:
                  getProportionateScreenWidth(getProportionateScreenWidth(28))),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(28)),
              border: Border.all(color: kTextColor)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              value: _selectedDiadiem,
              items: _dropdownMenuItems,
              onChanged: onChangeDropdownItem,
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
