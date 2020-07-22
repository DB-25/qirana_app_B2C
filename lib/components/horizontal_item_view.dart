import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'item_view_vertical.dart';
import 'package:qirana_app/screens/vertical_view_page.dart';

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
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => VerticalViewPage()));//TODO:ADD later
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
