import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/screens/vertical_view_page_2.dart';
import 'item_view_vertical.dart';
import 'package:qirana_app/screens/vertical_view_page.dart';

class HorizontalView extends StatelessWidget {
  final List<ProductModel> productModel;
  final String title;
  final Axis axisDirection;
  HorizontalView({this.title, this.axisDirection, this.productModel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 325,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerticalViewPage2(
                                bestDeals: productModel,
                                url: null,
                                title: 'BEST DEALS',
                                extendedUrl: null,
                                subCategory: null)));
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFFff5860),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: axisDirection,
                  itemCount: productModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemViewVertical(
                      productModel: productModel[index],
                      showQuantity: false,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
