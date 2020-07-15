import 'package:flutter/material.dart';

class ItemHorizontalView extends StatefulWidget {
  ItemHorizontalView({this.price, this.productName, this.url});

  final String productName;
  final int price;
  final String url;
  @override
  _ItemHorizontalViewState createState() => _ItemHorizontalViewState(
        price: price,
        productName: productName,
        url: url,
      );
}

class _ItemHorizontalViewState extends State<ItemHorizontalView> {
  _ItemHorizontalViewState({this.price, this.productName, this.url});
  final String productName;
  final int price;
  final String url;
  int value;
  int quantity = 1;

  @override
  void initState() {
    value = price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          elevation: 5,
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
                    child: Card(
                      child: Image.network(
                        url,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      productName,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
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
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
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
                                    if (quantity != 1) quantity--;
                                    value = price * quantity;
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
                          quantity.toString(),
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
                                  quantity++;
                                  value = price * quantity;
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
      ),
    );
  }
}
