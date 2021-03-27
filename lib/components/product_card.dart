import 'package:chocaycanh/components/title_text.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/model/products.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.product,
    this.press,
  }) : super(key: key);

  final Product product;
  final Function press;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return GestureDetector(
      onTap: press,
      child: Container(
        width: defaultSize * 18.5,
        decoration: BoxDecoration(
          color: kshopbackColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: AspectRatio(
          aspectRatio: 0.693,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(defaultSize),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/spinner.gif",
                      image: product.hinhmoi,
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: defaultSize / 2),
                child: TitleText(
                  title: product.ten,
                ),
              ),
              SizedBox(
                height: defaultSize / 2,
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: defaultSize),
                child: Text(
                    "${product.dongiakhuyenmai != null ? product.dongiakhuyenmai : product.dongia} vnđ"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
