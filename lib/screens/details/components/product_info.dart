import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/model/Store.dart';
import 'package:chocaycanh/model/products.dart';
import 'package:chocaycanh/screens/storedetail/store_detail.dart';
import 'package:chocaycanh/services/fetchStore.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat('###,###,###');
    double defaultSize = SizeConfig.defaultSize;
    var ten = product.ten;
    if (ten.length > 30) ten = ten.substring(0, 30);
    ten = ten.toUpperCase();
    Function storepress = () {
      storeNav(context, product.idcuahang);
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultSize * 2),
      height: defaultSize * 40.5,
      width: defaultSize * 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            product.tenloai.toUpperCase(),
            style: lighttextstyle,
          ),
          SizedBox(
            height: defaultSize,
          ),
          Text(ten,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(20),
                fontWeight: FontWeight.bold,
                letterSpacing: -0.8,
                height: 1.4,
              )),
          SizedBox(
            height: defaultSize,
          ),
          buildCuahang(storepress),
          buildYeuthich(),
          buildSoluong(),
          buildPrice(numberFormat, defaultSize),
          Spacer(),
          buildQrImage(defaultSize),
        ],
      ),
    );
  }

  QrImage buildQrImage(double defaultSize) {
    return QrImage(
      data: 'This QR code has an embedded image as well',
      version: QrVersions.auto,
      size: defaultSize * 12,
      gapless: false,
      //   embeddedImage: AssetImage('assets/images/logo.png'),
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(40, 40),
      ),
    );
  }

  Future<void> storeNav(BuildContext context, int id) async {
    Store store = await getStore(id);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => DetailStoreScreen(store: store)));
  }

  Widget buildCuahang(Function press) {
    return InkWell(
      onTap: press,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: getProportionateScreenWidth(2)),
            child: Icon(
              Icons.storefront,
              color: kPrimaryColor,
            ),
          ),
          Text(
            product.tencuahang,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Row buildSoluong() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: getProportionateScreenWidth(2)),
          child: Icon(
            Icons.shopping_bag_rounded,
            color: kPrimaryColor,
          ),
        ),
        Text(
          product.soluong.toString(),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Row buildYeuthich() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: getProportionateScreenWidth(2)),
          child: Icon(
            Icons.recommend,
            color: kActiveIconcolor,
          ),
        ),
        Text(
          product.yeuthich.toString(),
          textAlign: TextAlign.left,
        ),
        Spacer(),
      ],
    );
  }

  Widget buildPrice(NumberFormat numberFormat, double defaultSize) {
    print(product.dongiakhuyenmai);
    if (product.dongiakhuyenmai == null) {
      return Text("${numberFormat.format(product.dongia)} vnđ",
          style: pricetext);
    } else {
      return Column(
        children: [
          Text("${numberFormat.format(product.dongia)} vnđ", style: striketext),
          Text("${numberFormat.format(product.dongiakhuyenmai)} vnđ",
              style: pricetext),
        ],
      );
    }
  }
}
