import 'package:chocaycanh/components/product_card.dart';
import 'package:chocaycanh/model/products.dart';
import 'package:chocaycanh/screens/details/detailscreen.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

class RecommandProducts extends StatelessWidget {
  const RecommandProducts({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.all(defaultSize * 2),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.639,
          crossAxisCount:
              SizeConfig.orientation == Orientation.portrait ? 2 : 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          return ProductCard(
              product: products[index],
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailProductScreen(product: products[index])));
              });
        },
      ),
    );
  }
}
