import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/screens/item_bottom_sheet.dart';
import 'package:qirana_app/database/database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemViewVertical extends StatefulWidget {
  final ProductModel productModel;
  ItemViewVertical({this.productModel});
  @override
  _ItemViewVerticalState createState() =>
      _ItemViewVerticalState(productModel: productModel);
}

class _ItemViewVerticalState extends State<ItemViewVertical> {
  final ProductModel productModel;

  _ItemViewVerticalState({this.productModel});

  FToast fToast;

  _showToast(String msg) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black54,
      ),
      child: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    fToast = FToast(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) =>
                  ItemBottomSheet(product: productModel));
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3 + 45,
          height: MediaQuery.of(context).size.height / 4 + 90,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 3 + 15,
                      child: Image.network(
                        'https://www.fagnum.com/wp' + productModel.imageOne,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    child: Text(
                      productModel.name,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Rs ' + productModel.price.toString(),
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 18,
                            ),
                            onPressed: () {
                              productModel.quantity = 1.toString();
                              SQLiteDbProvider.db.insert(productModel, 0, 1);
                              _showToast('Item added to Favorite');
                            },
                          ),
                          IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.black45,
                              size: 18,
                            ),
                            onPressed: () {
                              productModel.quantity = 1.toString();
                              SQLiteDbProvider.db.insert(productModel, 1, 0);
                              _showToast('Item added to Cart');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
