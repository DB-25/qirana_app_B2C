import 'package:flutter/material.dart';
import 'package:qirana_app/components/input_field.dart';
import 'package:qirana_app/components/horizontal_item_view.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchTerm;
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
                  InputField(
                    hintText: 'Search',
                    validator: emptyValidator('This can\'t be empty'),
                    onSaved: (val) {
                      searchTerm = val;
                    },
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
