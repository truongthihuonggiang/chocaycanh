import 'package:chocaycanh/model/Giohang.dart';
import 'package:chocaycanh/screens/cart/components/changecart.dart';
import 'package:chocaycanh/services/fetchGiohang.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatefulWidget {
  CartCard({
    Key key,
    @required this.cart,
    @required this.callback,
  }) : super(key: key);

  Giohang cart;
  Changecart callback;
  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    var giatien = widget.cart.dongiakhuyenmai != null
        ? widget.cart.dongiakhuyenmai
        : widget.cart.dongia;
    print('----hinhanh:' + widget.cart.hinhmoi);
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(widget.cart.hinhmoi),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.cart.ten} (có ${widget.cart.soluongkho} sp)',
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white,
                    // foreground
                  ),
                  onPressed: () {
                    setState(() {
                      widget.cart.soluong = widget.cart.soluong + 1;
                      if (widget.cart.soluong > widget.cart.soluongkho)
                        widget.cart.soluong = widget.cart.soluongkho;
                      widget.callback.capnhatsoluong();
                      postCnsoluonggiohang(widget.cart.id, widget.cart.soluong);
                    });
                  },
                  child: Text('+'),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(4),
                ),
                Text.rich(
                  TextSpan(
                    text: "${giatien}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                    children: [
                      TextSpan(
                          text: " x${widget.cart.soluong}",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(4),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white,
                    // foreground
                  ),
                  onPressed: () {
                    setState(() {
                      widget.cart.soluong = widget.cart.soluong - 1;
                      if (widget.cart.soluong <= 0) widget.cart.soluong = 1;
                      widget.callback.capnhatsoluong();
                    });
                  },
                  child: Text('-'),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
