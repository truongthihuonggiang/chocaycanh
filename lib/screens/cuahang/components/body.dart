import 'package:chocaycanh/components/title_text.dart';
import 'package:chocaycanh/screens/cuahang/components/liststores.dart';
import 'package:chocaycanh/services/fetchStore.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return SafeArea(
      child: SizedBox(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadText(title: "Cửa hàng tiêu biểu"),
                FutureBuilder(
                  future: fetchStore(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? ListStore(
                          stores: snapshot.data,
                        )
                      : Center(child: Image.asset("assets/images/ripple.gif")),
                ),
                // Divider(
                //   height: 5,
                // ),

                //ProductCard(product: product, press: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
