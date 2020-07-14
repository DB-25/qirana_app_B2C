import 'package:flutter/material.dart';

class ItemBottomSheet extends StatefulWidget {
  ItemBottomSheet({this.price, this.productName, this.url});

  final String productName;
  final String price;
  final String url;
  @override
  _ItemBottomSheetState createState() => _ItemBottomSheetState(
        price: price,
        productName: productName,
        url: url,
      );
}

class _ItemBottomSheetState extends State<ItemBottomSheet> {
  _ItemBottomSheetState({this.price, this.productName, this.url});
  final String productName;
  final String price;
  final String url;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        height: 275,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                    ),
                    FloatingActionButton(
                        elevation: 0.5,
                        backgroundColor: Color(0xfff6f6f6),
                        onPressed: () {
                          setState(() {
                            if (quantity != 0) quantity--;
                          });
                        },
                        child: Text(
                          '-',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        )),
                    Text(
                      quantity.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                    ),
                    FloatingActionButton(
                      elevation: 0.5,
                      backgroundColor: Color(0xfff6f6f6),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 100,
                          child: Card(
                            child: Image.network(
                              url,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          productName,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ],
                    ),
                    Text(
                      price,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Color(0xFFff5860),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Add to cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
