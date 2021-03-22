import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/model/products.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultSize * 2),
      height: defaultSize * 37.5,
      width: defaultSize * 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            product.category.toUpperCase(),
            style: lighttextstyle,
          ),
          SizedBox(
            height: defaultSize,
          ),
          Text(product.title,
              style: TextStyle(
                fontSize: defaultSize * 2.4,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.8,
                height: 1.4,
              )),
          SizedBox(
            height: defaultSize * 2,
          ),
          Text("\$${product.price}",
              style: TextStyle(
                fontSize: defaultSize * 1.6,
                fontWeight: FontWeight.bold,
                height: 1.6,
              )),
        ],
      ),
    );
  }
}
