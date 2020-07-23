import 'package:flutter/material.dart';
import 'package:qirana_app/components/item_horizontal_view.dart';
import 'package:qirana_app/model/product_model.dart';

class VerticalViewPage extends StatefulWidget {
  final List<ProductModel> productModel;
  VerticalViewPage(this.productModel);
  @override
  _VerticalViewPageState createState() => _VerticalViewPageState(productModel);
}

class _VerticalViewPageState extends State<VerticalViewPage> {
  final List<ProductModel> productModel;
  _VerticalViewPageState(this.productModel);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 130,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'BEST DEALS',
                          style: TextStyle(
                              color: Color(0xFFff5860),
                              fontSize: 35,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          ItemHorizontalView(
                        url: 'https://www.fagnum.com/wp' +
                            productModel[index].imageOne,
                        productName: productModel[index].metaDescription,
                        price: productModel[index].price.toInt(),
                        quantity: 1,
                        size: productModel[index].size,
                      ),
                      itemCount: productModel.length,
                    ),
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
