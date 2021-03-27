import 'package:chocaycanh/components/title_text.dart';
import 'package:chocaycanh/model/Store.dart';
import 'package:chocaycanh/services/fetchProducts.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'listproduct.dart';

class Body extends StatelessWidget {
  final Store store;

  const Body({Key key, @required this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    var diachi = store.diachi == null ? '' : store.diachi;
    var dienthoai = store.dienthoai == null ? '' : store.dienthoai;
    var website = store.website == null ? '' : store.website;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          constraints: BoxConstraints(
            minHeight: getProportionateScreenHeight(750), //minimum height
          ),
          child: Column(
            children: [
              Container(
                height: getProportionateScreenHeight(315),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      store.hinhanh,
                      fit: BoxFit.cover,
                      height: getProportionateScreenHeight(315),
                      width: double.infinity,
                    ),
                    Column(
                      children: [
                        Spacer(),
                        Stack(
                          children: [
                            Container(
                              color: Colors.black.withOpacity(0.5),
                              width: double.infinity,
                              //    height: getProportionateScreenHeight(30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWithStroke(
                                    text: store.tencuahang,
                                    fontSize: getProportionateScreenHeight(30),
                                    strokeWidth: 4,
                                  ),
                                  textWithStroke(
                                      text: 'địa chỉ: $diachi',
                                      fontSize:
                                          getProportionateScreenHeight(20)),
                                  textWithStroke(
                                      text: 'điện thoại: $dienthoai',
                                      fontSize:
                                          getProportionateScreenHeight(20)),
                                  textWithStroke(
                                      text: website,
                                      fontSize:
                                          getProportionateScreenHeight(20)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                        alignment: Alignment.topRight,
                        child: buildQrImage(getProportionateScreenHeight(8))),
                  ],
                ),
              ),
              FutureBuilder(
                future: fetchProductStore(store.iduser),
                builder: (context, snapshot) => snapshot.hasData
                    ? Listproduct(
                        products: snapshot.data,
                      )
                    : Center(child: Image.asset("assets/images/ripple.gif")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQrImage(double defaultSize) {
    return Container(
      color: Colors.white,
      child: QrImage(
        data: store.madinhdanh,
        version: QrVersions.auto,
        size: defaultSize * 12,
        gapless: false,
        //   embeddedImage: AssetImage('assets/images/logo.png'),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(40, 40),
        ),
      ),
    );
  }

  Widget textWithStroke(
      {String text,
      double fontSize: 12,
      double strokeWidth: 1,
      Color textColor: Colors.white,
      Color strokeColor: Colors.black}) {
    return Stack(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(text, style: TextStyle(fontSize: fontSize, color: textColor)),
      ],
    );
  }
}
