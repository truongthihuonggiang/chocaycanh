import 'package:chocaycanh/components/default_button.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/model/Giohang.dart';
import 'package:chocaycanh/screens/cart/components/changecart.dart';
import 'package:chocaycanh/services/fetchGiohang.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: FutureBuilder(
        future: fetchGiohang(),
        builder: (context, snapshot) => snapshot.hasData
            ? ListCart(
                carts: snapshot.data,
              )
            : Center(child: Image.asset("assets/images/ripple.gif")),
      ),
    );
  }
}

class ListCart extends StatefulWidget {
  List<Giohang> carts;

  ListCart({Key key, @required this.carts}) : super(key: key);
  @override
  _ListCartState createState() => _ListCartState();
}

class _ListCartState extends State<ListCart> implements Changecart {
  int tong = 0;
  Map map = Map<int, int>();
  @override
  Widget build(BuildContext context) {
    tong = Tinhtong();
    // print('tong:' + tong.toString());
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: buildListView(),
              //    Spacer(),
              //      buildCheckout(),
            ),
            buildCheckout(),
          ],
        ),
      ),
    );
  }

  int Tinhtong() {
    int kq = 0;
    int i = 0;
    for (i = 0; i < widget.carts.length; i++) {
      print('cc' + widget.carts[i].check.toString());
      if (widget.carts[i].check == 1)
        kq = kq + widget.carts[i].soluong * widget.carts[i].dongia;
    }
    return kq;
  }

  Container buildCheckout() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(10),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     Container(
          //       padding: EdgeInsets.all(10),
          //       height: getProportionateScreenWidth(40),
          //       width: getProportionateScreenWidth(40),
          //       decoration: BoxDecoration(
          //         color: Color(0xFFF5F6F9),
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: SvgPicture.asset("assets/icons/receipt.svg"),
          //     ),
          //     Spacer(),
          //     Text("Add voucher code"),
          //     const SizedBox(width: 10),
          //     Icon(
          //       Icons.arrow_forward_ios,
          //       size: 12,
          //       color: kTextColor,
          //     )
          //   ],
          // ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: "Tổng:\n",
                  children: [
                    TextSpan(
                      text: "${tong} vnđ ",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(180),
                child: DefaultButton(
                  text: "Đặt hàng",
                  press: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildListView() {
    if (widget.carts.length > 0) {
      int idcuahang = -1;
      return ListView.builder(
          itemCount: widget.carts.length,
          itemBuilder: (context, index) {
            if (map[widget.carts[index].idcuahang] == null)
              map[widget.carts[index].idcuahang] = 1;
            //  var item = widget.carts[index];
            if (widget.carts[index].soluong > widget.carts[index].soluongkho) {
              widget.carts[index].soluong = widget.carts[index].soluongkho;
              //capnhat lai
              postCnsoluonggiohang(
                  widget.carts[index].id, widget.carts[index].soluong);
            }
            Widget devide = Container();
            if (widget.carts[index].idcuahang != idcuahang) {
              idcuahang = widget.carts[index].idcuahang;
              devide = Container(
                  alignment: Alignment.topLeft,
                  child: CheckboxListTile(
                    title: Text(
                      'Cửa hàng ${widget.carts[index].tencuahang}',
                      style: headtextstyle,
                    ),
                    value: map[widget.carts[index].idcuahang] == 1,
                    onChanged: (newValue) {
                      setState(() {
                        if (newValue == true)
                          map[widget.carts[index].idcuahang] = 1;
                        else
                          map[widget.carts[index].idcuahang] = 0;
                        capnhatcheck(widget.carts[index].idcuahang,
                            map[widget.carts[index].idcuahang]);
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ));
            }
            return Container(
              color: map[widget.carts[index].idcuahang] == 1
                  ? Colors.white
                  : kBackgroundColor,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  devide,
                  Dismissible(
                    key: Key(widget.carts[index].id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        widget.carts.removeAt(index);
                      });
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartCard(
                      cart: widget.carts[index],
                      callback: this,
                    ),
                  ),
                ],
              ),
            );
          });
    } else {
      return Text('Chưa có sản phẩm nào!');
    }
  }

  @override
  void capnhatsoluong() {
    // TODO: implement capnhatsoluong
    setState(() {
      tong = Tinhtong();
    });
  }

  void capnhatcheck(int idcuahang, int giatri) {
    // TODO: implement capnhatcheck
    int i = 0;
    int tam = 0;
    int dongia = 0;
    for (i = 0; i < widget.carts.length; i++) {
      if (widget.carts[i].idcuahang == idcuahang) {
        widget.carts[i].check = giatri;
        if (widget.carts[i].check == 1) {
          dongia = widget.carts[i].dongiakhuyenmai != null
              ? widget.carts[i].dongiakhuyenmai
              : widget.carts[i].dongia;
          tam = tam + dongia * widget.carts[i].soluong;
        }
      }
      setState(() {
        tong = tam;
      });
    }
  }
}
