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
import 'search_result.dart';
import 'inventory_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    autoLogin();
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  GoogleSignInAccount _currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  Future<void> _handleSignIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await _googleSignIn.signIn();
      await prefs.setBool('autoLogin', true);
    } catch (error) {
      print(error);
    }
  }

  Widget _buildBody() {
    return (_currentUser != null)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ListTile(
                leading: GoogleUserCircleAvatar(
                  identity: _currentUser,
                ),
                title: Text(
                  _currentUser.displayName ?? '',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  _currentUser.email ?? '',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Color(0xFFff5860),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    setState(() {
                      _handleSignIn();
                    });
                  },
                ),
              ],
            ),
          );
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();
  void autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('autoLogin' ?? false)) _googleSignIn.signInSilently();
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
        key: _scaffoldKey,
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
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          title: Text(
            'Qirana',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: _buildBody(),
                decoration: BoxDecoration(
                  color: Color(0xFFff5860),
                ),
              ),
              ListTile(
                title: Text(
                  'Check Inventory',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFff5860),
                      fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Inventory()));
                },
              ),
              ListTile(
                title: Text(
                  'Log Out',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFff5860),
                      fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  setState(() async {
                    _handleSignOut();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('autoLogin', false);
                  });

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                HorizontalCategory(
                  showTitle: true,
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
