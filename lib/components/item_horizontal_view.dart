import 'package:flutter/material.dart';

class ItemHorizontalView extends StatefulWidget {
  ItemHorizontalView({this.price, this.productName, this.url, this.quantity});

  final String productName;
  final int price;
  final String url;
  final quantity;
  @override
  _ItemHorizontalViewState createState() => _ItemHorizontalViewState(
      price: price, productName: productName, url: url, quantity: quantity);
}

class _ItemHorizontalViewState extends State<ItemHorizontalView> {
  _ItemHorizontalViewState(
      {this.price, this.productName, this.url, this.quantity});
  final String productName;
  final int price;
  final String url;
  int value;
  final quantity;
  int Quantity;

  @override
  void initState() {
    Quantity = quantity;
    value = price;
    super.initState();
  }

  int getValue() {
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 110,
                  width: 110,
                  child: Image.network(
                    url,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    productName,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Rs ' + value.toString(),
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        child: FittedBox(
                          child: FloatingActionButton(
                              elevation: 5,
                              backgroundColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  if (Quantity != 1) Quantity--;
                                  value = price * Quantity;
                                });
                              },
                              child: Text(
                                '-',
                                style: TextStyle(
                                    fontSize: 30, color: Color(0xFFff5860)),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        Quantity.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        child: FittedBox(
                          child: FloatingActionButton(
                            elevation: 5,
                            backgroundColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                Quantity++;
                                value = price * Quantity;
                              });
                            },
                            child: Text(
                              '+',
                              style: TextStyle(
                                  fontSize: 30, color: Color(0xFFff5860)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
