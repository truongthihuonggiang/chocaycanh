import 'package:chocaycanh/components/title_text.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/model/Cateogies.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.all(defaultSize * 2),
      child: SizedBox(
          width: defaultSize * 20.5,
          child: AspectRatio(
            aspectRatio: 0.83,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                    //     color: Colors.blue,
                    ),
                ClipPath(
                  clipper: CategoryCustomeShap(),
                  child: AspectRatio(
                      aspectRatio: 1.025,
                      child: Container(
                        padding: EdgeInsets.all(defaultSize * 2),
                        color: kshopbackColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TitleText(title: category.ten),
                            SizedBox(
                              height: defaultSize,
                            ),
                            // Text(
                            //   "${category.numOfProducts}+ Products",
                            //   style:
                            //       TextStyle(color: kTextColor.withOpacity(0.6)),
                            // ),
                          ],
                        ),
                      )),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AspectRatio(
                    aspectRatio: 1.15,
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/spinner.gif",
                      imageErrorBuilder: (BuildContext context,
                          Object exception, StackTrace stackTrace) {
                        return Text('Lỗi');
                      },
                      image: category.hinhanh,
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class CategoryCustomeShap extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double height = size.height;
    double width = size.width;
    double cornerSize = 30;
    path.lineTo(0, height - cornerSize);
    path.quadraticBezierTo(0, height, cornerSize, height);
    path.lineTo(width - cornerSize, height);
    path.quadraticBezierTo(width, height, width, height - cornerSize);
    path.lineTo(width, cornerSize);
    path.quadraticBezierTo(width, 0, width - cornerSize, 0);
    path.lineTo(cornerSize, cornerSize * 0.75);
    path.quadraticBezierTo(0, cornerSize, 0, cornerSize * 2);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
