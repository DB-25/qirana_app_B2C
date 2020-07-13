import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemViewVertical extends StatefulWidget {
  @override
  _ItemViewVerticalState createState() => _ItemViewVerticalState();
}

class _ItemViewVerticalState extends State<ItemViewVertical> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
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
                    'https://www.jessicagavin.com/wp-content/uploads/2019/02/carrots-7-600x900.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Carrot',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Rs 100',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    );
  }
}
