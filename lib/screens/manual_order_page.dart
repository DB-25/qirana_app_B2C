import 'package:flutter/material.dart';

class ManualOrder extends StatefulWidget {
  @override
  _ManualOrderState createState() => _ManualOrderState();
}

class _ManualOrderState extends State<ManualOrder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: TextField(
          smartDashesType: SmartDashesType.enabled,
          onSubmitted: (value) {
            setState(() {
              value += ',';
            });

            print(value);
          },
        ),
      ),
    );
  }
}
