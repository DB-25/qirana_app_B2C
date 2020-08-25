import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/screens/item_bottom_sheet.dart';
import 'package:qirana_app/database/database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemViewVertical extends StatefulWidget {
  final bool showQuantity;
  final ProductModel productModel;
  ItemViewVertical({this.productModel, this.showQuantity});
  @override
  _ItemViewVerticalState createState() => _ItemViewVerticalState(
      productModel: productModel, showQuantity: showQuantity);
}

class _ItemViewVerticalState extends State<ItemViewVertical> {
  final ProductModel productModel;
  final bool showQuantity;
  _ItemViewVerticalState({this.productModel, this.showQuantity});

  FToast fToast;
  int quantity = 0;

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
    quantity = int.parse(productModel.quantity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemBottomSheet(
                        product: productModel,
                      )));
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3 + 45,
          height: MediaQuery.of(context).size.height / 6 + 10,
          child: Card(
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 3 + 15,
                      child: Image.network(
                        'https://api.fagnum.com/wp' + productModel.imageOne,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5),
                  child: Container(
                    child: Text(
                      productModel.name,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      (quantity == 0)
                          ? Text(
                              'Rs ' + productModel.price.round().toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            )
                          : Text(
                              'Rs ' +
                                  (productModel.price * quantity)
                                      .round()
                                      .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                      (showQuantity)
                          ? SizedBox(
                              width: 30,
                            )
                          : SizedBox(
                              width: 10,
                            ),
                      (showQuantity)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  height: 25,
                                  width: 25,
                                  child: FittedBox(
                                    child: FloatingActionButton(
                                        elevation: 5,
                                        backgroundColor: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            if (quantity > 0) quantity--;
                                            productModel.quantity =
                                                quantity.toString();
                                            if (quantity == 0)
                                              SQLiteDbProvider.db.delete(
                                                  productModel.productId);
                                            else
                                              SQLiteDbProvider.db
                                                  .update(productModel, 1, 0);
                                            if (quantity != 0)
                                              _showToast('Item added to Cart');
                                          });
                                        },
                                        child: Text(
                                          '-',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Color(0xFFff5860)),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 25,
                                  width: 25,
                                  child: FittedBox(
                                    child: FloatingActionButton(
                                      elevation: 5,
                                      backgroundColor: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                          productModel.quantity =
                                              quantity.toString();
                                          if (quantity == 1)
                                            SQLiteDbProvider.db
                                                .insert(productModel, 1, 0);
                                          else
                                            SQLiteDbProvider.db
                                                .update(productModel, 1, 0);
                                          if (quantity != 0)
                                            _showToast('Item added to Cart');
                                        });
                                      },
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Color(0xFFff5860)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
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
                                    SQLiteDbProvider.db
                                        .insert(productModel, 0, 1);
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
                                    SQLiteDbProvider.db
                                        .insert(productModel, 1, 0);
                                    _showToast('Item added to Cart');
                                  },
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
