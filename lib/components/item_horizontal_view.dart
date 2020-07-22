import 'package:flutter/material.dart';

class ItemHorizontalView extends StatefulWidget {
  ItemHorizontalView(
      {this.price, this.productName, this.url, this.quantity, this.size});

  final String size;
  final String productName;
  final int price;
  final String url;
  final quantity;
  @override
  _ItemHorizontalViewState createState() => _ItemHorizontalViewState(
      price: price,
      productName: productName,
      url: url,
      quantity: quantity,
      size: size);
}

class _ItemHorizontalViewState extends State<ItemHorizontalView> {
  _ItemHorizontalViewState(
      {this.price, this.productName, this.url, this.quantity, this.size});
  final String productName;
  final int price;
  final String url;
  final String size;
  int value;
  final quantity;
  int quan;

  @override
  void initState() {
    quan = quantity;
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
        width: MediaQuery.of(context).size.width * 0.8,
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
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        productName,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            size,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Rs ' + value.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 30,
                                    width: 30,
                                    child: FittedBox(
                                      child: FloatingActionButton(
                                          elevation: 5,
                                          backgroundColor: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              if (quan != 1) quan--;
                                              value = price * quan;
                                            });
                                          },
                                          child: Text(
                                            '-',
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Color(0xFFff5860)),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    quan.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    child: FittedBox(
                                      child: FloatingActionButton(
                                        elevation: 5,
                                        backgroundColor: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            quan++;
                                            value = price * quan;
                                          });
                                        },
                                        child: Text(
                                          '+',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Color(0xFFff5860)),
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
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
