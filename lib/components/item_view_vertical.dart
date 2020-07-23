import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qirana_app/screens/item_bottom_sheet.dart';

class ItemViewVertical extends StatefulWidget {
  final String productName;
  final double price;
  final String url;
  ItemViewVertical({this.price, this.productName, this.url});
  @override
  _ItemViewVerticalState createState() =>
      _ItemViewVerticalState(productName: productName, price: price, url: url);
}

class _ItemViewVerticalState extends State<ItemViewVertical> {
  final String productName;
  final double price;
  final String url;
  _ItemViewVerticalState({this.price, this.productName, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => ItemBottomSheet(
                    price: price,
                    productName: productName,
                    url: url,
                  ));
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3 + 40,
          height: MediaQuery.of(context).size.height / 4 + 90,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 3 + 15,
                      child: Image.network(
                        'https://www.fagnum.com/wp' + url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    productName,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    softWrap: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Rs ' + price.toInt().toString(),
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 18,
                            ),
                            onPressed: () {
                              //TODO:ADD
                            },
                          ),
                          IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.black45,
                              size: 18,
                            ),
                            onPressed: () {
                              //TODO:ADD
                            },
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
      ),
    );
  }
}
