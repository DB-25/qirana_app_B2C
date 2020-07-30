import 'package:flutter/material.dart';
import 'package:qirana_app/components/input_field.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/model/order_detail_model.dart';
import 'package:qirana_app/networking/ApiResponse.dart';
import 'package:qirana_app/networking/api_driver.dart';

class AddressPage extends StatefulWidget {
  final List<ProductModel> products;
  AddressPage({this.products});
  @override
  _AddressPageState createState() => _AddressPageState(products: products);
}

final _formKey = GlobalKey<FormState>();
final scaffoldKey = GlobalKey<ScaffoldState>();

var formData = {
  'area': '',
  'city': '',
  'contactNumber': '',
  'contestName': '',
  'country': '',
  'emailId': '',
  'houseNo': '',
  'name': '',
  'orderId': '',
  'paymentOption': '',
  'paymentOrderId': '',
  'state': '',
  'referralCode': '',
};

class _AddressPageState extends State<AddressPage> {
  ApiDriver apiDriver = new ApiDriver();
  OrderDetailModel addressDetails;
  final List<ProductModel> products;
  _AddressPageState({this.products});
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
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            'Delivery Details',
                            style: TextStyle(
                                color: Color(0xFFff5860),
                                fontSize: 35,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.text,
                          hintText: 'Name',
                          validator: emptyValidator('Enter a Name'),
                          onSaved: (val) => formData['name'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.emailAddress,
                          hintText: 'Email Id',
                          validator: emailValidator(),
                          onSaved: (val) => formData['emailId'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.number,
                          hintText: 'Contact Number',
                          validator: emptyValidator('Cant be Empty'),
                          onSaved: (val) => formData['contactNumber'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.number,
                          hintText: 'House No',
                          validator: emptyValidator('Cant be Empty'),
                          onSaved: (val) => formData['houseNo'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.text,
                          hintText: 'City',
                          validator: emptyValidator('Cant be Empty'),
                          onSaved: (val) => formData['city'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.text,
                          hintText: 'Area',
                          validator: emptyValidator('Cant be Empty'),
                          onSaved: (val) => formData['area'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.text,
                          hintText: 'State',
                          validator: emptyValidator('Cant be Empty'),
                          onSaved: (val) => formData['state'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.text,
                          hintText: 'Country',
                          validator: emptyValidator('Cant be Empty'),
                          onSaved: (val) => formData['country'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.text,
                          hintText: 'Referral Code',
                          validator: null,
                          onSaved: (val) => formData['referralCode'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          hintText: 'Contest Name',
                          validator: null,
                          onSaved: (val) => formData['contestName'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          hintText: 'Payment Option',
                          validator: emptyValidator('Cant be Empty'),
                          onSaved: (val) => formData['paymentOption'] = val,
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
                              "Confirm",
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
                        onPressed: () async {
                          _formKey.currentState.save();
                          if (!_formKey.currentState.validate()) return;
                          addressDetails = OrderDetailModel.fromMap(formData);
                          ApiResponse response = await apiDriver.orderDetails(
                              orderDetailModel: addressDetails,
                              productModel: products);
                          print(response.data);
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
