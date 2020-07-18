import 'package:flutter/material.dart';
import 'package:qirana_app/components/item_horizontal_view.dart';

class VerticalViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 130,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'BEST DEALS',
                          style: TextStyle(
                              color: Color(0xFFff5860),
                              fontSize: 35,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          ItemHorizontalView(
                        url:
                            'https://www.jessicagavin.com/wp-content/uploads/2019/02/carrots-7-600x900.jpg',
                        productName: 'Carrot',
                        price: 150,
                        quantity: 1,
                      ),
                      itemCount: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
