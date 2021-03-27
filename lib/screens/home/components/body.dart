import 'package:chocaycanh/components/title_text.dart';

import 'package:chocaycanh/screens/home/components/recommand_product.dart';
import 'package:chocaycanh/services/fetchCategories.dart';
import 'package:chocaycanh/services/fetchProducts.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

import 'categories.dart';

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
                HeadText(title: "Danh mục"),
                FutureBuilder(
                  future: fetchCategories(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? ListCategory(
                          categories: snapshot.data,
                        )
                      : Center(child: Image.asset("assets/images/ripple.gif")),
                ),
                Divider(
                  height: 5,
                ),
                HeadText(title: "Có thể bạn quan tâm"),
                FutureBuilder(
                  future: fetchProducts(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? RecommandProducts(
                          products: snapshot.data,
                        )
                      : Center(child: Image.asset("assets/images/ripple.gif")),
                ),
                Divider(
                  height: 5,
                ),
                //ProductCard(product: product, press: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
