import 'package:chocaycanh/components/default_button.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/model/products.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        // constraints: BoxConstraints(minHeight: defaultSize * 44),
        padding: EdgeInsets.only(
            top: defaultSize * 5,
            left: defaultSize * 2,
            right: defaultSize * 2),
        // height: 800,
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
                  SvgPicture.asset("assets/icons/Heart Icon_2.svg",
                      height: getProportionateScreenWidth(20),
                      color: kActiveIconcolor),
                ],
              ),
            ),
            Text(product.ten,
                style: TextStyle(
                    fontSize: defaultSize * 1.8, fontWeight: FontWeight.bold)),
            SizedBox(
              height: defaultSize * 3,
            ),
            Text(
              product.mota,
              style: TextStyle(color: kTextColor.withOpacity(0.7), height: 1.5),
            ),
            SizedBox(
              height: defaultSize * 3,
            ),
            DefaultButton(text: 'Mua hàng', press: press),
            SizedBox(
              height: defaultSize * 3,
            ),
          ],
        ),
      ),
    );
  }

  Row buildComment() {
    var soluong = product.soluong;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '($soluong) bình luận ',
          textAlign: TextAlign.left,
          style: textlink,
        ),
      ],
    );
  }

  Row buildGallery() {
    var soluong = product.soluong;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '($soluong) bộ ảnh ',
          textAlign: TextAlign.left,
          style: textlink,
        ),
      ],
    );
  }
}
