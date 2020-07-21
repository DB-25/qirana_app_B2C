import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:qirana_app/components/horizontal_category.dart';
import 'package:qirana_app/components/vertical_item_view.dart';
import 'package:qirana_app/components/horizontal_item_view.dart';
import 'package:qirana_app/components/input_field.dart';
import 'package:qirana_app/model/category_model.dart';
import 'package:qirana_app/networking/api_driver.dart';
import 'package:qirana_app/networking/ApiResponse.dart';
import 'package:qirana_app/model/banner_model.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  String searchedTerm;
  ApiDriver apiDriver = new ApiDriver();
  BannerModel bannerModel;
  List<CategoryModel> categoryModel = List<CategoryModel>();

  @override
  void initState() {
    getDataForAll();
    super.initState();
  }

  void getDataForAll() async {
    ApiResponse responseBanner = await apiDriver.getData('banner-all');
    getBannerDetails(responseBanner.listData[0]);
    ApiResponse responseCategory = await apiDriver.getData('category-all');
    getCategoryDetails(responseCategory.listData);
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

  void getCategoryDetails(List data) {
    for (var i = 0; i < data.length; i++) {
      categoryModel.add(CategoryModel.fromMap(data[i]));
    }
  }

  void getBannerDetails(Map<String, dynamic> map) {
    bannerModel = BannerModel.fromMap(map);
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
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 55,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 8,
                          child: InputField(
                            hintText: 'Search',
                            validator: null,
                            onSaved: (val) {
                              searchedTerm = val;
                            },
                          ),
                        ),
                        Expanded(flex: 1, child: Icon(Icons.notifications))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
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
                VerticalView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
