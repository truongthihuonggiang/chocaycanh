import 'package:chocaycanh/components/product_card.dart';
import 'package:chocaycanh/components/storecard.dart';
import 'package:chocaycanh/model/Store.dart';

import 'package:chocaycanh/screens/details/detailscreen.dart';
import 'package:chocaycanh/screens/storedetail/store_detail.dart';
import 'package:chocaycanh/size_config.dart';
import 'package:flutter/material.dart';

class ListStore extends StatelessWidget {
  const ListStore({
    Key key,
    @required this.stores,
  }) : super(key: key);

  final List<Store> stores;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.all(0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: stores.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.639,
          crossAxisCount:
              SizeConfig.orientation == Orientation.portrait ? 2 : 4,
          mainAxisSpacing: getProportionateScreenWidth(10),
          crossAxisSpacing: getProportionateScreenWidth(10),
        ),
        itemBuilder: (context, index) {
          return StoreCard(
              store: stores[index],
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailStoreScreen(store: stores[index])));
              });
        },
      ),
    );
  }
}
