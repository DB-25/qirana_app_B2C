import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'item_view_vertical.dart';

class HorizontalView extends StatelessWidget {
  final String title;
  final Axis axisDirection;
  HorizontalView({this.title, this.axisDirection});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 355,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //TODO:ADD Feature
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
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemViewVertical();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
