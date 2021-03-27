import 'package:chocaycanh/components/title_text.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/model/Store.dart';

import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({
    Key key,
    @required this.store,
    this.press,
  }) : super(key: key);

  final Store store;
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
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(30)),
        ),
        child: AspectRatio(
          aspectRatio: 0.693,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(defaultSize),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenWidth(10)),
                    child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/spinner.gif",
                        image: store.hinhanh,
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: defaultSize / 2),
                child: TitleText(
                  title: store.tencuahang,
                ),
              ),
              SizedBox(
                height: defaultSize / 2,
              ),
              Spacer(),
              Padding(
                padding:
                    EdgeInsets.only(left: defaultSize, bottom: defaultSize),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.place),
                    Text(store.tentinh),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
