import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Color color1;
  final Color color2;
  final IconData icon;
  final String text1;
  final String text2;

  CategoryCard({this.color1, this.color2, this.icon, this.text1, this.text2});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 85,
        height: 85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    icon,
                    color: color2,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                        text1,
                        style: TextStyle(color: color2),
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
