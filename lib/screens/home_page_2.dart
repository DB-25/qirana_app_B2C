import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:qirana_app/components/horizontal_category.dart';
import 'package:qirana_app/components/vertical_item_view.dart';
import 'package:qirana_app/components/horizontal_item_view.dart';
import 'package:qirana_app/model/category_model.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/networking/api_driver.dart';
import 'package:qirana_app/model/banner_model.dart';
import 'package:qirana_app/screens/search_result.dart';

class HomePage2 extends StatefulWidget {
  final BannerModel bannerModel;
  final List<CategoryModel> categoryModel;
  final List<ProductModel> productModel;
  HomePage2({this.bannerModel, this.productModel, this.categoryModel});
  @override
  _HomePage2State createState() => _HomePage2State(
      bannerModel: bannerModel,
      productModel: productModel,
      categoryModel: categoryModel);
}

class _HomePage2State extends State<HomePage2> {
  ApiDriver apiDriver = new ApiDriver();
  BannerModel bannerModel;
  List<CategoryModel> categoryModel;
  List<ProductModel> productModel;
  _HomePage2State({this.bannerModel, this.productModel, this.categoryModel});

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchResult()));
                                },
                                child: ListTile(
                                  leading: Icon(Icons.search),
                                  title: Text(
                                    'Search a Product',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black54),
                                  ),
//                                title: TextField(
//                                  onSubmitted: (searchedTerm) {
//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                            builder: (context) => SearchResult(
//                                                  search: searchedTerm,
//                                                )));
//                                  },
//                                  style: TextStyle(fontSize: 18),
//                                  keyboardType: TextInputType.text,
//                                  cursorColor: Colors.black,
//                                  showCursor: true,
//                                  autocorrect: true,
//                                  autofocus: false,
//                                  decoration: new InputDecoration(
//                                      border: InputBorder.none,
//                                      focusedBorder: InputBorder.none,
//                                      enabledBorder: InputBorder.none,
//                                      errorBorder: InputBorder.none,
//                                      disabledBorder: InputBorder.none,
//                                      contentPadding: EdgeInsets.only(
//                                          bottom: 11, top: 11, right: 15),
//                                      hintText: 'Search a Product'),
//                                ),
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Icon(Icons.notifications))
                      ],
                    ),
                  ),
                ),
                HorizontalCategory(
                  categoryModel: categoryModel,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: bannerModel == null
                          ? Container(
                              color: Colors.white,
                            )
                          : Carousel(
                              images: [
                                NetworkImage('https://www.fagnum.com/wp' +
                                    bannerModel.bannerOne),
                                NetworkImage('https://www.fagnum.com/wp' +
                                    bannerModel.bannerTwo),
                                NetworkImage('https://www.fagnum.com/wp' +
                                    bannerModel.bannerThree)
                              ],
                              boxFit: BoxFit.fill,
                              showIndicator: true,
                              dotIncreaseSize: 1.5,
                              dotBgColor: Colors.black.withOpacity(0),
                              dotColor: Colors.white.withOpacity(0.4),
                              borderRadius: false,
                              moveIndicatorFromBottom: 180.0,
                              noRadiusForIndicator: true,
                              overlayShadow: false,
                              overlayShadowColors: Colors.white,
                              overlayShadowSize: 0.7,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                HorizontalView(
                  productModel: productModel,
                  title: 'BEST DEALS',
                  axisDirection: Axis.horizontal,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'POPULAR THIS WEEK',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                ),
                VerticalView(
                  productModel: productModel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
