import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qirana_app/components/icon_btn.dart';
import 'package:qirana_app/database/database.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/networking/api_driver.dart';
import 'package:qirana_app/screens/item_bottom_sheet.dart';

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
    fToast = FToast();
    fToast.init(context);
    if (productModel != null) quantity = int.parse(productModel.quantity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
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
          width: MediaQuery.of(context).size.width / 2 - 20,
          height: MediaQuery.of(context).size.height / 6 + 10,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: Colors.white,
            elevation: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width / 3 + 15,
                        child: Hero(
                            tag: 'image',
                            child: CachedNetworkImage(
                              imageUrl:ApiDriver().getBaseUrl()+'/wp' +
                                  productModel.imageOne,
                              placeholder: (context, url) => Container(child:Image.asset('assets/logo.png',width: 80,height: 80,)),
                              errorWidget: (context, url, error) => Container(width: 150,height: 150,child:Image.asset('assets/no_image.png',)),
                            ),
                            /*FadeInImage(
                              // here `bytes` is a Uint8List containing the bytes for the in-memory image
                              placeholder: AssetImage('assets/logo.png'),
                              image: NetworkImage(
                                'https://api.fagnum.com/wp' +
                                    productModel.imageOne,
                              ),
                            )*/
                            /*Image.network(
                            'https://api.fagnum.com/wp' + productModel.imageOne,
                            fit: BoxFit.contain,
                          ),*/
                            ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 30,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 5),
                      child: Container(
                        child: Text(
                          productModel.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Container(
                        width: 125,
                        alignment: Alignment(-1.2, -0.5),
                        child: RichText(
                          text: TextSpan(
                            text: /*'Size: '*/ "",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                            children: <TextSpan>[
                              TextSpan(
                                text: productModel.size,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      // trailing: SizedBox(
                      //   width: 48,
                      //   height: 15,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         color: Colors.green,
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(3))),
                      //     child: Center(
                      //       child: Text(
                      //         ((productModel.retailPrice != 0.0)
                      //                     ? ((productModel.mrp -
                      //                             productModel.retailPrice) /
                      //                         productModel.mrp *
                      //                         100)
                      //                     : (100.0))
                      //                 .floor()
                      //                 .toString() +
                      //             "% OFF",
                      //         style:
                      //             TextStyle(color: Colors.white, fontSize: 10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: (quantity == 0)
                                  ? Text(
                                      '₹ ' +
                                          productModel.retailPrice
                                              .round()
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17),
                                    )
                                  : Text(
                                      '₹ ' +
                                          (productModel.retailPrice * quantity)
                                              .round()
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17),
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: (quantity == 0)
                                  ? Text(
                                      '₹ ' +
                                          productModel.mrp.round().toString(),
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    )
                                  : Text(
                                      '₹ ' +
                                          (productModel.mrp * quantity)
                                              .round()
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        (showQuantity)
                            ? Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: FittedBox(
                                          child: IconBtn(
                                              icon: Icon(Icons.remove,
                                                  color: Colors.black54),
                                              press:
                                                  () {
                                                setState(() {
                                                  if (quantity > 0) quantity--;
                                                  productModel.quantity =
                                                      quantity.toString();
                                                  if (quantity == 0)
                                                    SQLiteDbProvider.db.delete(
                                                        productModel.productId);
                                                  else
                                                    SQLiteDbProvider.db.update(
                                                        productModel, 1, 0);
                                                  if (quantity != 0)
                                                    _showToast(
                                                        'Item added to Cart');
                                                });
                                              }), /*FloatingActionButton(
                                            elevation: 0,
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
                                                  SQLiteDbProvider.db.update(
                                                      productModel, 1, 0);
                                                if (quantity != 0)
                                                  _showToast(
                                                      'Item added to Cart');
                                              });
                                            },
                                            child:  Text(
                                              '-',
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black45),
                                            ),
                                            // }
                                          ),*/
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: FittedBox(
                                          child: IconBtn(
                                              icon: Icon(Icons.add,
                                                  color: Colors.black54),
                                              press:
                                                  () {
                                                    setState(() {
                                                      quantity++;
                                                      productModel.quantity =
                                                          quantity.toString();
                                                      if (quantity == 1)
                                                        SQLiteDbProvider.db.insert(
                                                            productModel, 1, 0);
                                                      else
                                                        SQLiteDbProvider.db.update(
                                                            productModel, 1, 0);
                                                      if (quantity != 0)
                                                        _showToast(
                                                            'Item added to Cart');
                                                    });
                                              }),/*FloatingActionButton(
                                            elevation: 0,
                                            backgroundColor: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                quantity++;
                                                productModel.quantity =
                                                    quantity.toString();
                                                if (quantity == 1)
                                                  SQLiteDbProvider.db.insert(
                                                      productModel, 1, 0);
                                                else
                                                  SQLiteDbProvider.db.update(
                                                      productModel, 1, 0);
                                                if (quantity != 0)
                                                  _showToast(
                                                      'Item added to Cart');
                                              });
                                            },
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black45),
                                            ),
                                          ),*/
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    )
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: IconButton(
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
                                    ),
                                    Expanded(
                                      child: IconButton(
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
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
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
