import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'favorite_page.dart';
import 'search_page.dart';
import 'profile_page.dart';
import 'home_page_2.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                builder = (BuildContext context) => HomePage2();
                break;
              case '/search':
                builder = (BuildContext context) => Search();
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
            icon: Icon(Icons.person_outline),
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
