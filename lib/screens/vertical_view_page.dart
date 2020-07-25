import 'package:flutter/material.dart';
import 'package:qirana_app/components/item_horizontal_view.dart';
import 'package:qirana_app/model/category_model.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:qirana_app/components/horizontal_category.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
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
                          title,
                          style: TextStyle(
                              color: Color(0xFFff5860),
                              fontSize: 35,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 80,
                    child: SearchBar(onSearch: null, onItemFound: null),
                  ),
                  subCategory == null
                      ? Container()
                      : HorizontalCategory(
                          categoryModel: getData(subCategory),
                        ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>
                            ItemHorizontalView(
                          product: productModel[index],
                        ),
                        itemCount: productModel.length,
                      ),
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
