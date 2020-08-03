import 'package:flutter/material.dart';
import 'package:qirana_app/components/item_horizontal_view.dart';
import 'package:qirana_app/model/category_model.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/components/horizontal_category.dart';
import 'search_result.dart';

class VerticalViewPage extends StatefulWidget {
  final String title;
  final List<ProductModel> productModel;
  final List subCategory;
  VerticalViewPage(this.productModel, this.subCategory, this.title);
  @override
  _VerticalViewPageState createState() =>
      _VerticalViewPageState(productModel, subCategory, title);
}

class _VerticalViewPageState extends State<VerticalViewPage> {
  final String title;
  final List subCategory;
  final List<ProductModel> productModel;
  _VerticalViewPageState(this.productModel, this.subCategory, this.title);
  final List<CategoryModel> categoryModel = List<CategoryModel>();

  List<CategoryModel> getData(List data) {
    for (var i = 0; i < data.length; i++) {
      categoryModel.add(CategoryModel.fromMap(data[i]));
    }
    return categoryModel;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchResult()));
              }),
          IconButton(
              icon: Icon(
                Icons.notifications_active,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5),
            child: Container(
              height: MediaQuery.of(context).size.height - 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  subCategory == null
                      ? Container()
                      : HorizontalCategory(
                          showTitle: false,
                          categoryModel: getData(subCategory),
                        ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          ItemHorizontalView(
                        product: productModel[index],
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
