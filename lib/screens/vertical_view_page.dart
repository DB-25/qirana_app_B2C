import 'package:flutter/material.dart';
import 'package:qirana_app/components/item_horizontal_view.dart';
import 'package:qirana_app/model/category_model.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/components/horizontal_category.dart';
import 'package:qirana_app/networking/ApiResponse.dart';
import 'search_result.dart';
import 'package:qirana_app/networking/api_driver.dart';

class VerticalViewPage extends StatefulWidget {
  final String url;
  final String extendedUrl;
  final String title;
  final List<ProductModel> productModel;
  final List subCategory;
  VerticalViewPage(this.productModel, this.subCategory, this.title, this.url,
      this.extendedUrl);
  @override
  _VerticalViewPageState createState() => _VerticalViewPageState(
      productModel, subCategory, title, url, extendedUrl);
}

class _VerticalViewPageState extends State<VerticalViewPage> {
  final String url;
  final String extendedUrl;
  final String title;
  final List subCategory;
  final List<ProductModel> productModel;

  _VerticalViewPageState(this.productModel, this.subCategory, this.title,
      this.url, this.extendedUrl);

  final List<CategoryModel> categoryModel = List<CategoryModel>();

  List<CategoryModel> getData(List data) {
    for (var i = 0; i < data.length; i++) {
      categoryModel.add(CategoryModel.fromMap(data[i]));
    }
    return categoryModel;
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pageData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;

  List<ProductModel> tempList = List();
  final ApiDriver apiDriver = new ApiDriver();
  void getNewData(List data) {
    for (var i = 0; i < data.length; i++) {
      tempList.add(ProductModel.fromMap(data[i]));
    }
  }

  int index = 0;

  void pageData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      index += 10;
      tempList.clear();
      if (url != null) {
        ApiResponse response = await apiDriver.getCategoryData(
            url: url, extendedUrl: extendedUrl, index: index);
        if (response != null) getNewData(response.data);
      }
      productModel.addAll(tempList);
      setState(() {
        isLoading = false;
      });
    }
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
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == productModel.length) {
                          return _buildProgressIndicator();
                        } else
                          return ItemHorizontalView(
                            product: productModel[index],
                          );
                      },
                      itemCount: (productModel.length != 0)
                          ? productModel.length + 1
                          : 0,
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
