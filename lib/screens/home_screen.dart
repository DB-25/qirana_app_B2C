import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'profile_page.dart';
import 'cart_page.dart';
import 'favorite_page.dart';
import 'search_page.dart';
import 'home_page_2.dart';
import 'package:qirana_app/model/category_model.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/networking/api_driver.dart';
import 'package:qirana_app/networking/ApiResponse.dart';
import 'package:qirana_app/model/banner_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<int> navigationStack = [];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (navigationStack.isEmpty) navigationStack.add(0);
      if (navigationStack.last != index) navigationStack.add(index);
      if (_selectedIndex == 0)
        _navigatorKey.currentState.pushNamed('/');
      else if (_selectedIndex == 1)
        _navigatorKey.currentState.pushNamed('/search');
      else if (_selectedIndex == 2)
        _navigatorKey.currentState.pushNamed('/cart');
      else if (_selectedIndex == 3)
        _navigatorKey.currentState.pushNamed('/fav');
      else if (_selectedIndex == 4)
        _navigatorKey.currentState.pushNamed('/profile');
    });
  }

  Future<bool> _exitApp() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("NO"),
                ),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("YES"),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    getDataForAll();
    super.initState();
  }

  ApiDriver apiDriver = new ApiDriver();
  BannerModel bannerModel;
  List<CategoryModel> categoryModel = List<CategoryModel>();
  List<ProductModel> productModel = List<ProductModel>();

  void getDataForAll() async {
    ApiResponse responseBanner = await apiDriver.getData('banner-all');
    if (responseBanner != null) getBannerDetails(responseBanner.data[0]);
    ApiResponse responseCategory = await apiDriver.getData('category-all');
    ApiResponse responseBestDeals = await apiDriver.getData('product-slider');
    getCategoryDetails(responseCategory.data);
    getBestDealsDetails(responseBestDeals.data);
  }

  void getBestDealsDetails(List data) {
    for (var i = 0; i < data.length; i++) {
      productModel.add(ProductModel.fromMap(data[i]));
    }
  }

  void getCategoryDetails(List data) {
    for (var i = 0; i < data.length; i++) {
      categoryModel.add(CategoryModel.fromMap(data[i]));
    }
  }

  void getBannerDetails(Map<String, dynamic> map) {
    bannerModel = BannerModel.fromMap(map);
  }

//  GoogleSignInAccount _currentUser;
//  GoogleSignIn _googleSignIn = GoogleSignIn(
//    scopes: [
//      'email',
//    ],
//  );
//  Future<void> _handleSignIn() async {
//    try {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      await _googleSignIn.signIn();
//      await prefs.setBool('autoLogin', true);
//    } catch (error) {
//      print(error);
//    }
//  }
//
//  Widget _buildBody() {
//    return (_currentUser != null)
//        ? Column(
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              ListTile(
//                leading: GoogleUserCircleAvatar(
//                  identity: _currentUser,
//                ),
//                title: Text(
//                  _currentUser.displayName ?? '',
//                  style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 18,
//                      fontWeight: FontWeight.w600),
//                ),
//                subtitle: Text(
//                  _currentUser.email ?? '',
//                  style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 15,
//                      fontWeight: FontWeight.w600),
//                ),
//              ),
//            ],
//          )
//        : Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                RaisedButton(
//                  color: Color(0xFFff5860),
//                  child: Container(
//                    height: 50,
//                    width: double.infinity,
//                    child: Padding(
//                      padding: const EdgeInsets.only(left: 30.0),
//                      child: ListTile(
//                        title: Padding(
//                          padding: const EdgeInsets.only(left: 20.0, bottom: 5),
//                          child: Text(
//                            "Sign In",
//                            style: TextStyle(
//                              fontWeight: FontWeight.w800,
//                              color: Colors.white,
//                              fontSize: 25,
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(10),
//                  ),
//                  onPressed: () {
//                    setState(() {
//                      _handleSignIn();
//                    });
//                  },
//                ),
//              ],
//            ),
//          );
//  }
//
//  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
//      appBar: AppBar(
//        actions: <Widget>[
//          IconButton(
//              icon: Icon(
//                Icons.search,
//                color: Colors.black,
//              ),
//              onPressed: () {
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => SearchResult()));
//              }),
//          IconButton(
//              icon: Icon(
//                Icons.notifications_active,
//                color: Colors.black,
//              ),
//              onPressed: () {})
//        ],
//        elevation: 0,
//        leading: IconButton(
//          icon: Icon(
//            Icons.menu,
//            color: Colors.black,
//          ),
//          onPressed: () {
//            _scaffoldKey.currentState.openDrawer();
//          },
//        ),
//        title: Text(
//          appBarTitle,
//          style: TextStyle(color: Colors.black),
//        ),
//        backgroundColor: Colors.white,
//      ),
//      drawer: Drawer(
//        child: ListView(
//          padding: EdgeInsets.zero,
//          children: <Widget>[
//            DrawerHeader(
//              child: _buildBody(),
//              decoration: BoxDecoration(
//                color: Color(0xFFff5860),
//              ),
//            ),
//            ListTile(
//              title: Text(
//                'Check Inventory',
//                style: TextStyle(
//                    fontSize: 18,
//                    color: Color(0xFFff5860),
//                    fontWeight: FontWeight.w700),
//              ),
//              onTap: () {
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => Inventory()));
//              },
//            ),
//            ListTile(
//              title: Text(
//                'Log Out',
//                style: TextStyle(
//                    fontSize: 18,
//                    color: Color(0xFFff5860),
//                    fontWeight: FontWeight.w700),
//              ),
//              onTap: () {
//                setState(() async {
//                  _handleSignOut();
//                  SharedPreferences prefs =
//                      await SharedPreferences.getInstance();
//                  await prefs.setBool('autoLogin', false);
//                });
//
//                Navigator.pop(context);
//              },
//            ),
//          ],
//        ),
//      ),
      body: WillPopScope(
        onWillPop: () async {
          if (navigationStack.isNotEmpty) {
            _navigatorKey.currentState.pop();
            navigationStack.removeLast();
            setState(() {
              _onItemTapped(navigationStack.last);
            });
            return false;
          } else if (navigationStack.isEmpty) {
            _exitApp();
          }
          return true;
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            // Manage your route names here
            switch (settings.name) {
              case '/':
                builder = (BuildContext context) => HomePage2(
                      productModel: productModel,
                      bannerModel: bannerModel,
                      categoryModel: categoryModel,
                    );
                break;
              case '/search':
                builder = (BuildContext context) => Search(
                      productModel: productModel,
                    );
                break;
              case '/cart':
                builder = (BuildContext context) => Cart();
                break;
              case '/fav':
                builder = (BuildContext context) => Fav();
                break;
              case '/profile':
                builder = (BuildContext context) => Profile();
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            // You can also return a PageRouteBuilder and
            // define custom transitions between pages
            return MaterialPageRoute(
              builder: builder,
              settings: settings,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 200,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              '',
              style: TextStyle(fontSize: 0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              '',
              style: TextStyle(fontSize: 0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text(
              '',
              style: TextStyle(fontSize: 0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text(
              '',
              style: TextStyle(fontSize: 0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(
              '',
              style: TextStyle(fontSize: 0),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange[500],
        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped,
        iconSize: 30,
      ),
    );
  }
}
