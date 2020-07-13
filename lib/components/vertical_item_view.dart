import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'item_view_vertical.dart';

class VerticalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: MediaQuery.of(context).size.height - 200,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  ItemViewVertical(),
                  ItemViewVertical(),
                ],
              );
            }),
      ),
    );
  }
}