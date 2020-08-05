import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qirana_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignInAccount _currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

//  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
//    _googleSignIn.signInSilently();
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
        key: scaffoldKey,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.pinkAccent])),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
              child: Center(child: _buildBody()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_currentUser != null) {
      return Container();
    } else {
      return Center(
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
                    leading: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        height: 35,
                        width: 35,
                        child: Image.asset(
                          'assets/google.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
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
                _handleSignIn();
              },
            ),
          ],
        ),
      );
    }
  }
}
