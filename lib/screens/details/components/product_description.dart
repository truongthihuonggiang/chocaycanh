import 'package:chocaycanh/components/default_button.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/model/products.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.product,
    this.press,
  }) : super(key: key);

  final Product product;
  final Function press;
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Container(
      constraints: BoxConstraints(minHeight: defaultSize * 44),
      padding: EdgeInsets.only(
          top: defaultSize * 5, left: defaultSize * 2, right: defaultSize * 2),
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultSize * 1.2),
          topRight: Radius.circular(defaultSize * 1.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(product.subTitle,
              style: TextStyle(
                  fontSize: defaultSize * 1.8, fontWeight: FontWeight.bold)),
          SizedBox(
            height: defaultSize * 3,
          ),
          Text(
            product.description,
            style: TextStyle(color: kTextColor.withOpacity(0.7), height: 1.5),
          ),
          SizedBox(
            height: defaultSize * 3,
          ),
          DefaultButton(text: 'Mua hàng', press: press),
        ],
      ),
    );
  }
}
