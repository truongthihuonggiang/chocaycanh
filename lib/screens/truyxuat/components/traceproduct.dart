import 'package:chocaycanh/model/Ccproduct.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class TraceProducts extends StatelessWidget {
  final Ccproduct producttrace;

  const TraceProducts({Key key, this.producttrace}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Function storepress = () {
      storeNav(context, producttrace.idcuahang);
    };
    var length1 = producttrace.dstheodoi.length;
    var length2 = producttrace.dschamsoc.length;
    var length3 = producttrace.dssohuu.length;
    NumberFormat numberFormat = NumberFormat('###,###,###');
    print('length1: ' + length1.toString());
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              buildHeader(),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  producttrace.tenloai.toLowerCase(),
                  style: lighttextstyle,
                ),
                Text(producttrace.ten.toUpperCase(),
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(20),
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.8,
                      height: 1.4,
                    )),
                buildCuahang(storepress),
                buildPrice(numberFormat),
                Text(producttrace.mota),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Text('Các mốc phát triển của cây', style: headtextstyle),
          buildTheodoi(length1, numberFormat),
          Text('Quá trình chăm sóc cây cảnh', style: headtextstyle),
          buildChamsoc(length2, numberFormat),
          Text('Quá trình mua bán cây cảnh', style: headtextstyle),
          buildSohuu(length3, numberFormat),
        ],
      ),
    );
  }

  ClipRRect buildHeader() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: FadeInImage.assetNetwork(
          placeholder: "assets/images/spinner.gif",
          image: producttrace.hinhanh,
          imageErrorBuilder: (context, error, stackTrace) {
            return Text('lỗi');
          },
          fit: BoxFit.cover),
    );
  }

  Widget buildCuahang(Function press) {
    return InkWell(
      onTap: press,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: getProportionateScreenWidth(2)),
            child: Icon(
              Icons.storefront,
              color: kPrimaryColor,
            ),
          ),
          Text(
            "bán tại ${producttrace.tencuahang}",
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget buildPrice(NumberFormat numberFormat) {
    double defaultSize = getProportionateScreenWidth(10);
    print(producttrace.dongiakhuyenmai);
    if (producttrace.dongiakhuyenmai == null) {
      return Text("${numberFormat.format(producttrace.dongia)} vnđ",
          style: pricetext);
    } else {
      return Column(
        children: [
          Text("${numberFormat.format(producttrace.dongia)} vnđ",
              style: striketext),
          Text("${numberFormat.format(producttrace.dongiakhuyenmai)} vnđ",
              style: pricetext),
        ],
      );
    }
  }

  Padding buildSohuu(int length1, NumberFormat numberFormat) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
      child: Column(
        children: List.generate(length1, (index) {
          return SizedBox(
            width: double.infinity,
            child: TimelineTile(
              alignment: TimelineAlign.start,

              //   startChild: Text('starrt'),
              endChild: Container(
                color: kBackgroundColor,
                margin: EdgeInsets.all(getProportionateScreenWidth(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                      child: Text(producttrace.dssohuu[index].created_at,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(producttrace.dssohuu[index].tennguoidung ==
                                      null
                                  ? 'chủ sở hữu: ' +
                                      producttrace.dssohuu[index].tencuahang
                                  : 'chủ sở hữu: ' +
                                      producttrace.dssohuu[index].tennguoidung),
                              Text(producttrace.dssohuu[index].diachi == null
                                  ? ''
                                  : 'địa chỉ: ' +
                                      producttrace.dssohuu[index].diachi),
                            ],
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
              indicatorStyle: IndicatorStyle(
                color: Colors.orange,
                width: getProportionateScreenWidth(20),
                height: getProportionateScreenHeight(20),
              ),
              beforeLineStyle: LineStyle(
                color: kPrimaryColor,
                thickness: 3,
              ),
              afterLineStyle: LineStyle(
                color: kPrimaryColor,
                thickness: 3,
              ),
              isFirst: index == 0 ? true : false,
              isLast: index == length1 - 1 ? true : false,
              //isLast: true,
            ),
          );
        }),
      ),
    );
  }

  Widget buildChamsoc(int length1, NumberFormat numberFormat) {
    if (producttrace.dschamsoc != null) {
      print(producttrace.dschamsoc);
      return Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
        child: Column(
          children: List.generate(length1, (index) {
            return SizedBox(
              width: double.infinity,
              child: TimelineTile(
                alignment: TimelineAlign.start,

                //   startChild: Text('starrt'),
                endChild: Container(
                  color: kBackgroundColor,
                  margin: EdgeInsets.all(getProportionateScreenWidth(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                        child: Text(producttrace.dschamsoc[index].created_at,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        children: [
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(
                                  getProportionateScreenWidth(5)),
                              child: Image.network(
                                  producttrace.dschamsoc[index].hinhanh),
                            ),
                            width: getProportionateScreenWidth(70),
                            //    height: getProportionateScreenWidth(40),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(
                                  getProportionateScreenWidth(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(producttrace.dschamsoc[index].hoatdong ==
                                          null
                                      ? ''
                                      : producttrace.dschamsoc[index].hoatdong),
                                  Text(producttrace.dschamsoc[index].diadiem ==
                                          null
                                      ? ''
                                      : producttrace.dschamsoc[index].diadiem),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                indicatorStyle: IndicatorStyle(
                  color: Colors.orange,
                  width: getProportionateScreenWidth(20),
                  height: getProportionateScreenHeight(20),
                ),
                beforeLineStyle: LineStyle(
                  color: kPrimaryColor,
                  thickness: 3,
                ),
                afterLineStyle: LineStyle(
                  color: kPrimaryColor,
                  thickness: 3,
                ),
                isFirst: index == 0 ? true : false,
                isLast: index == length1 - 1 ? true : false,
                //isLast: true,
              ),
            );
          }),
        ),
      );
    } else
      return Container();
  }

  Padding buildTheodoi(int length1, NumberFormat numberFormat) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
      child: Column(
        children: List.generate(length1, (index) {
          return SizedBox(
            width: double.infinity,
            child: TimelineTile(
              alignment: TimelineAlign.start,
              //   startChild: Text('starrt'),
              endChild: Container(
                color: kBackgroundColor,
                margin: EdgeInsets.all(getProportionateScreenWidth(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                      child: Text(producttrace.dstheodoi[index].created_at,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        Container(
                          child: Padding(
                            padding:
                                EdgeInsets.all(getProportionateScreenWidth(5)),
                            child: Image.network(
                                producttrace.dstheodoi[index].hinhanh),
                          ),
                          width: getProportionateScreenWidth(70),
                          //    height: getProportionateScreenWidth(40),
                        ),
                        Expanded(
                            child: Padding(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(producttrace.dstheodoi[index].ghichu),
                              Text(
                                  "${numberFormat.format(producttrace.dstheodoi[index].giatien)} vnđ"),
                            ],
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
              indicatorStyle: IndicatorStyle(
                color: Colors.orange,
                width: getProportionateScreenWidth(20),
                height: getProportionateScreenHeight(20),
              ),
              beforeLineStyle: LineStyle(
                color: kPrimaryColor,
                thickness: 3,
              ),
              afterLineStyle: LineStyle(
                color: kPrimaryColor,
                thickness: 3,
              ),
              isFirst: index == 0 ? true : false,
              isLast: index == length1 - 1 ? true : false,
              //isLast: true,
            ),
          );
        }),
      ),
    );
  }
}
