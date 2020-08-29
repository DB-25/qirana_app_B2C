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
import 'package:qirana_app/screens/address_page.dart';
import 'package:qirana_app/screens/login_screen.dart';
import 'package:qirana_app/screens/manual_order_page.dart';
import 'search_result.dart';
import 'inventory_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final ValueNotifier<bool> autoLoginBool = ValueNotifier<bool>(false);

final ValueNotifier<bool> admin = ValueNotifier<bool>(false);

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

  _handleSignOut() {
    _googleSignIn.disconnect();
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    admin.value = prefs.containsKey('admin') ? true : false;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    admin.notifyListeners();
    if (prefs.containsKey('autoLogin')) {
      _googleSignIn.signInSilently();
      autoLoginBool.value = prefs.getBool('autoLogin');
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      autoLoginBool.notifyListeners();
    }
    setState(() {});
  }

  @override
  void initState() {
    autoLogin();
    refresh();
    super.initState();
  }

  void refresh() {
    Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        loading = false;
      });
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
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  bool loading = true;

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
                  Icons.add_a_photo,
                  color: Colors.black,
                ),
                onPressed: () {
                  getImage();
                  if (_image != null)
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddressPage(
                                  products: null,
                                )));
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Qirana',
                      style: TextStyle(fontSize: 55, color: Colors.white),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFff5860),
                ),
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: autoLoginBool,
                  builder: (BuildContext context, bool value, Widget child) {
                    return (value)
                        ? Container()
                        : ListTile(
                            title: Text(
                              "Log In",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFff5860),
                                fontSize: 18,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                          );
                  }),
              ValueListenableBuilder<bool>(
                  valueListenable: admin,
                  builder: (BuildContext context, bool value, Widget child) {
                    return (value)
                        ? ListTile(
                            title: Text(
                              'Check Inventory',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFff5860),
                                  fontWeight: FontWeight.w700),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Inventory()));
                            },
                          )
                        : Container();
                  }),
              ListTile(
                title: Text(
                  'Shop by Category',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFff5860),
                      fontWeight: FontWeight.w700),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Order',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFff5860),
                      fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ManualOrder()));
                },
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: autoLoginBool,
                  builder: (BuildContext context, bool value, Widget child) {
                    return (value)
                        ? ListTile(
                            title: Text(
                              'Log Out',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFff5860),
                                  fontWeight: FontWeight.w700),
                            ),
                            onTap: () async {
                              setState(() {
                                _handleSignOut();
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              autoLoginBool.value = false;
                              // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                              autoLoginBool.notifyListeners();
                              await prefs.clear();
                              admin.value = false;
                              // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                              admin.notifyListeners();
                              setState(() {});
                            },
                          )
                        : Container();
                  }),
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
                categoryModel == null
                    ? Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : HorizontalCategory(
                        showTitle: true,
                        categoryModel: categoryModel,
                        duration: 3,
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
                      child: loading
                          ? Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Carousel(
                              images: [
                                NetworkImage(
                                    'https://api.fagnum.com/wp/home/ff80818171b2ad0501720ab097fd0006/bannerOne/banner-one.png'),
                                NetworkImage(
                                    'https://api.fagnum.com/wp/home/ff80818171b2ad0501720ab097fd0006/bannerTwo/banner-2.jpg'),
                                NetworkImage(
                                    'https://api.fagnum.com/wp/home/ff80818171b2ad0501720ab097fd0006/bannerThree/banner-3.png')
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
                productModel == null
                    ? Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : HorizontalView(
                        productModel: productModel,
                        title: 'BEST DEALS',
                        axisDirection: Axis.horizontal,
                        duration: 5,
                      ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'POPULAR THIS WEEK',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                ),
                productModel == null
                    ? Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : VerticalView(
                        productModel: productModel,
                        duration: 5,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
