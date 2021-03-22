import 'package:chocaycanh/model/products.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

import 'product_description.dart';
import 'product_info.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key key, @required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return SafeArea(
      child: SingleChildScrollView(
          child: SizedBox(
        width: double.infinity,
        height: SizeConfig.screenHeight - AppBar().preferredSize.height,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductInfo(product: product),
            Positioned(
                top: defaultSize * 37.5,
                left: 0,
                right: 0,
                child: ProductDescription(product: product, press: () {})),
            Positioned(
              top: defaultSize * 9.5,
              right: -defaultSize * 7.5,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                height: defaultSize * 37.8,
                width: defaultSize * 36.4,
              ),
            )
          ],
        ),
      )),
    );
  }
}
