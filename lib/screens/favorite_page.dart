import 'package:flutter/material.dart';
import 'package:qirana_app/components/vertical_item_view.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/database/database.dart';

class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  List<ProductModel> products = List();
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    products = await SQLiteDbProvider.db.getFav();
    Future.delayed(new Duration(seconds: 1), () {
      setState(() {});
    });
    Future.delayed(new Duration(seconds: 2), () {
      setState(() {});
    });
    Future.delayed(new Duration(seconds: 3), () {
      setState(() {});
    });
    Future.delayed(new Duration(seconds: 5), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10),
                    child: Text(
                      'FAVOURITES',
                      style: TextStyle(
                          color: Color(0xFFff5860),
                          fontSize: 35,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  (products.isEmpty)
                      ? Container(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'No Items in Favorite',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                        )
                      : VerticalView(
                          productModel: products,
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
