import 'package:flutter/material.dart';
import 'package:qirana_app/components/input_field.dart';
import 'package:qirana_app/components/password_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

final _formKey = GlobalKey<FormState>();
final scaffoldKey = GlobalKey<ScaffoldState>();
var formData = {
  'email': '',
  'firstName': '',
  'lastName': '',
  'password': '',
  'contactNo': ''
};

class _RegisterScreenState extends State<RegisterScreen> {
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
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Color(0xFFff5860),
                            fontSize: 35,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          hintText: 'Email',
                          validator: emailValidator(),
                          onSaved: (val) => formData['email'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          hintText: 'First Name',
                          validator: emailValidator(),
                          onSaved: (val) => formData['firstName'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          hintText: 'Last Name',
                          validator: emailValidator(),
                          onSaved: (val) => formData['lastName'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: PasswordField(
                          hintText: "Password",
                          icon: Icons.lock,
                          validator:
                              passwordValidator("Password must not be empty"),
                          onSaved: (val) => formData['password'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          hintText: 'Phone Number',
                          validator: emailValidator(),
                          onSaved: (val) => formData['contactNo'] = val,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        color: Color(0xFFff5860),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          _formKey.currentState.save();
                          if (!_formKey.currentState.validate()) return;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
