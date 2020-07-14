import 'package:flutter/material.dart';
import 'category_card.dart';

class HorizontalCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 125,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'SHOP BY CATEGORIES',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) =>
                        CategoryCard()))
          ],
        ),
      ),
    );
  }
}
