import 'package:chocaycanh/services/fetchProducts.dart';
import 'package:flutter/material.dart';
import 'traceproduct.dart';

class Body extends StatelessWidget {
  final String madinhdanh;

  const Body({Key key, @required this.madinhdanh}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              FutureBuilder(
                future: fetchProductTracebility(madinhdanh),
                builder: (context, snapshot) => snapshot.hasData
                    ? TraceProducts(
                        producttrace: snapshot.data,
                      )
                    : Center(child: Image.asset("assets/images/ripple.gif")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
