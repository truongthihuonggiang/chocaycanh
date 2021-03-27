import 'package:chocaycanh/components/product_card.dart';
import 'package:chocaycanh/model/products.dart';
import 'package:chocaycanh/screens/details/detailscreen.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Listproduct extends StatelessWidget {
  const Listproduct({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            color: kBackgroundColor,
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            alignment: Alignment.topRight,
            child: Row(
              children: [
                buildComment(),
                Spacer(),
                buildGallery(),
                Spacer(),
              ],
            ),
          ),
          GridView.builder(
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
        ],
      ),
    );
  }

  Row buildComment() {
    var soluong = products.length;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '($soluong) sản phẩm ',
          textAlign: TextAlign.left,
          style: textlink,
        ),
      ],
    );
  }

  Row buildGallery() {
    var soluong = 15;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$soluong điểm ',
          textAlign: TextAlign.left,
          style: textlink,
        ),
      ],
    );
  }
}
