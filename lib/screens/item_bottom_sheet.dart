import 'package:flutter/material.dart';
import 'package:qirana_app/database/database.dart';
import 'package:qirana_app/model/product_model.dart';

class ItemBottomSheet extends StatefulWidget {
  ItemBottomSheet({this.product});
  final ProductModel product;
  @override
  _ItemBottomSheetState createState() =>
      _ItemBottomSheetState(productModel: product);
}

class _ItemBottomSheetState extends State<ItemBottomSheet> {
  _ItemBottomSheetState({this.productModel});
  ProductModel productModel;
  int quantity;
  @override
  void initState() {
    quantity = int.parse(productModel.quantity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        height: 275,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                    ),
                    FloatingActionButton(
                        elevation: 0.5,
                        backgroundColor: Color(0xfff6f6f6),
                        onPressed: () {
                          setState(() {
                            if (quantity > 0) quantity--;
                            productModel.quantity = quantity.toString();
                          });
                        },
                        child: Text(
                          '-',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        )),
                    Text(
                      quantity.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                    ),
                    FloatingActionButton(
                      elevation: 0.5,
                      backgroundColor: Color(0xfff6f6f6),
                      onPressed: () {
                        setState(() {
                          quantity++;
                          productModel.quantity = quantity.toString();
                        });
                      },
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 100,
                          child: Card(
                            child: Image.network(
                              'https://www.fagnum.com/wp' +
                                  productModel.imageOne,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text(
                            productModel.metaDescription,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Rs ' + productModel.price.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Color(0xFFff5860),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Add to cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    if (quantity != 0)
                      SQLiteDbProvider.db.insert(productModel, 1, 0, quantity);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
