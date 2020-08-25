import 'package:flutter/material.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/database/database.dart';
import 'address_page.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int total = 0;
  List<ProductModel> products = List();
  List<int> quantity = List();
  int itemCount = 0;
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  void getData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      products = await SQLiteDbProvider.db.getCart();
      if (products.isNotEmpty) {
        quantity.clear();
        itemCount = products.length;
        total = 0;
        for (int i = 0; i < itemCount; i++)
          total = total +
              (products[i].price.toInt() * int.parse(products[i].quantity));
        for (int i = 0; i < itemCount; i++)
          quantity.add(int.parse(products[i].quantity));
      }
      if (products.isEmpty) {
        itemCount = 0;
        total = 0;
      }
      setState(() {
        isLoading = false;
      });
    }
//    Future.delayed(new Duration(seconds: 1), () {
//      setState(() {});
//    });
//    Future.delayed(new Duration(seconds: 2), () {
//      setState(() {});
//    });
//    Future.delayed(new Duration(seconds: 3), () {
//      setState(() {});
//    });
//    Future.delayed(new Duration(seconds: 5), () {
//      setState(() {});
//    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'MY CART',
                      style: TextStyle(
                          color: Color(0xFFff5860),
                          fontSize: 35,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '$itemCount Products',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              isLoading
                  ? _buildProgressIndicator()
                  : Expanded(
                      child: products.isEmpty
                          ? Text(
                              'No Items in the Cart',
                              style: TextStyle(
                                  fontSize: 30, color: Colors.black54),
                            )
                          : ListView.builder(
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'https://api.fagnum.com/wp' +
                                          products[index].imageOne,
                                      height: 100,
                                      width: 55,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  title: Text(
                                    products[index].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17),
                                    maxLines: 2,
                                    softWrap: true,
                                  ),
                                  subtitle: Text(
                                    products[index].size,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  trailing: Container(
                                    height: 100,
                                    width: 90,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          (quantity[index] == 0)
                                              ? Text(
                                                  'Rs ' +
                                                      products[index]
                                                          .price
                                                          .round()
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 17),
                                                )
                                              : Text(
                                                  'Rs ' +
                                                      (products[index].price *
                                                              quantity[index])
                                                          .round()
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 17),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                height: 25,
                                                width: 25,
                                                child: FittedBox(
                                                  child: FloatingActionButton(
                                                      elevation: 5,
                                                      backgroundColor:
                                                          Colors.white,
                                                      onPressed: () {
                                                        setState(() {
                                                          if (quantity[index] >
                                                              0)
                                                            quantity[index]--;
                                                          products[index]
                                                                  .quantity =
                                                              quantity[index]
                                                                  .toString();
                                                          if (quantity[index] ==
                                                              0)
                                                            SQLiteDbProvider.db
                                                                .delete(products[
                                                                        index]
                                                                    .productId);
                                                          else
                                                            SQLiteDbProvider.db
                                                                .update(
                                                                    products[
                                                                        index],
                                                                    1,
                                                                    0);
                                                          getData();
                                                        });
                                                      },
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Color(
                                                                0xFFff5860)),
                                                      )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                quantity[index].toString(),
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
                                                    backgroundColor:
                                                        Colors.white,
                                                    onPressed: () {
                                                      setState(() {
                                                        quantity[index]++;
                                                        products[index]
                                                                .quantity =
                                                            quantity[index]
                                                                .toString();
                                                        if (quantity[index] ==
                                                            1)
                                                          SQLiteDbProvider.db
                                                              .insert(
                                                                  products[
                                                                      index],
                                                                  1,
                                                                  0);
                                                        else
                                                          SQLiteDbProvider.db
                                                              .update(
                                                                  products[
                                                                      index],
                                                                  1,
                                                                  0);
                                                        getData();
                                                      });
                                                    },
                                                    child: Text(
                                                      '+',
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color: Color(
                                                              0xFFff5860)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              itemCount: itemCount,
                            ),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Your Order',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      'Rs ' + total.toString(),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                    )
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
                        "Checkout",
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
                    if (total >= 2000)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressPage(
                            products: products,
                          ),
                        ),
                      );
                    else
                      _showDialog();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Cart Value Low"),
          content: new Text("Order min of Rs.2000"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
                child: new Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}
