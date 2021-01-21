import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qirana_app/components/icon_btn.dart';
import 'package:qirana_app/model/orders_item_model.dart';

class OrderDetail extends StatefulWidget {
  String data;

  OrderDetail({this.data});

  @override
  _OrderDetailState createState() => _OrderDetailState(data: data);
}

class _OrderDetailState extends State<OrderDetail> {
  String data;
  List<OrderItemModel> orderItems = List<OrderItemModel>();

  _OrderDetailState({this.data});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final List t = jsonDecode(data);
    orderItems = t.map((item) => OrderItemModel.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8,top: 10,right: 5),
                  child: IconBtn(
                    icon: Icon(Icons.arrow_back, color: Colors.black45),
                    press: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Text(
                    'Order Detail',
                    style: TextStyle(
                        color: Color(0xFFff5860),
                        fontSize: 25,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.grey.withOpacity(0.1),
              height: 1,
              margin: EdgeInsets.only(top: 10),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () => {},
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey.withOpacity(0.1),
                        height: 1,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(
                          title: Text(
                            orderItems[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                            maxLines: 2,
                            softWrap: true,
                          ),
                          subtitle: Text(
                            "Quantity: " +
                                orderItems[index].quantity.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                          trailing: Container(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Rs." +
                                    orderItems[index].price.toString() +
                                    " /-",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                itemCount: orderItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
