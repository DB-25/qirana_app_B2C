import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:qirana_app/components/horizontal_item_view.dart';
import 'package:qirana_app/model/product_model.dart';

class Search extends StatefulWidget {
  final List<ProductModel> productModel;
  Search({this.productModel});
  @override
  _SearchState createState() => _SearchState(productModel: productModel);
}

class _SearchState extends State<Search> {
  String searchTerm;
  final List<ProductModel> productModel;
  _SearchState({this.productModel});

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
  void initState() {
    refresh();
    print(productModel);
    super.initState();
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'I\'M LOOKING',
                    style: TextStyle(
                        color: Color(0xFFff5860),
                        fontSize: 35,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    'FOR...',
                    style: TextStyle(
                        color: Color(0xFFff5860),
                        fontSize: 35,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 80,
                    child: SearchBar(
                      onSearch: null,
                      onItemFound: null,
                      minimumChars: 3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Search history',
                    style: TextStyle(color: Colors.black45),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            searchTerm = 'Ground Coffee';
                          },
                          child: ListTile(
                            title: Text("Ground Coffee"),
                            leading: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.access_time,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                        ),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          searchTerm = 'Hand Sanitizer';
                        },
                        child: ListTile(
                          title: Text("Hand Sanitiser"),
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.access_time,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                        ),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HorizontalView(
                    productModel: productModel,
                    title: 'BEST DEALS',
                    axisDirection: Axis.horizontal,
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
