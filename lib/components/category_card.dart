import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 85,
        height: 85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xff066E4B)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.accessibility,
                    color: Color(0xffF4C458),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Health',
                        style: TextStyle(color: Color(0xffF4C458)),
                      ),
                      Text(
                        '& Care',
                        style: TextStyle(color: Color(0xffF4C458)),
                      ),
                    ],
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
