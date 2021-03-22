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
        width: defaultSize * 14.5,
        decoration: BoxDecoration(
          color: kshopbackColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: AspectRatio(
          aspectRatio: 0.693,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/spinner.gif",
                    image: product.image,
                    fit: BoxFit.cover),
              ),
              TitleText(title: product.title),
              SizedBox(
                height: defaultSize / 2,
              ),
              Text("\$${product.price}"),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
