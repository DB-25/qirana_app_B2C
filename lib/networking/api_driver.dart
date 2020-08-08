import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qirana_app/model/order_detail_model.dart';
import 'package:qirana_app/model/order_model.dart';
import 'package:qirana_app/networking/ApiResponse.dart';
import 'package:qirana_app/model/product_model.dart';
import 'ApiResponse.dart';

class ApiDriver {
  final String baseUrl =
      'http://145.239.92.37:8080/fagnum-test-api/ecom-store/';
  final String companyId = 'ff80818171b2ad0501720ab097fd0006';

  Future<ApiResponse<dynamic>> getData(String type) async {
    final http.Response response = await http.post(baseUrl + type,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'companyId': companyId}));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) {
      return null;
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (responseMap["status"]) {
        print(responseMap["status"]);
        throw Exception('Failed to load data models');
      } else {
        return ApiResponse.fromMap(responseMap);
      }
    }
  }

  Future<ApiResponse<dynamic>> login(String email, String password) async {
    final http.Response response = await http.post(
        'http://145.239.92.37:8080/auth-app/auth/login',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'companyId': companyId,
          'email': email,
          'password': password
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) {
      return null;
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (!responseMap["status"]) {
        print(responseMap["status"]);
        throw Exception('Failed to load data models');
      } else {
        return ApiResponse.fromMap(responseMap);
      }
    }
  }

  Future<ApiResponse<dynamic>> getCategoryData(
      {String url, String extendedUrl, int index}) async {
    final http.Response response = await http.post(
      baseUrl + extendedUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'companyId': companyId,
          'url': url,
          'index': index.toString()
        },
      ),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) {
      return null;
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (responseMap["status"]) {
        print(responseMap["status"]);
        throw Exception('Failed to load data models');
      } else {
        return ApiResponse.fromMap(responseMap);
      }
    }
  }

//class ApiDriver {
//  final String baseUrl = 'https://api.fagnum.com/ecom-store/';
//  final String companyId = 'ff80818171b2ad0501720ab097fd0006';
//
//  Future<ApiResponse<dynamic>> getData(String type) async {
//    final http.Response response =
//        await http.get(baseUrl + type + '?companyId=' + companyId);
//    print(response.statusCode);
//    print(response.body);
//    if (response.statusCode != 200) {
//      throw Exception('Failed to save data');
//    } else {
//      Map<String, dynamic> responseMap = jsonDecode(response.body);
//      if (responseMap["status"]) {
//        print(responseMap["status"]);
//        throw Exception('Failed to load data models');
//      } else {
//        return ApiResponse.fromMap(responseMap);
//      }
//    }
//  }

  Future<ApiResponse<dynamic>> getSubCategory(String categoryId) async {
    final http.Response response = await http.post(
        'http://145.239.92.37:8080/fagnum-test-api/ecom-store/sub-category-by-category-id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "categoryId": categoryId,
          "companyId": companyId
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to save data');
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (responseMap["status"]) {
        print(responseMap["status"]);
        throw Exception('Failed to load data models');
      } else {
        return ApiResponse.fromMap(responseMap);
      }
    }
  }

  Future<ApiResponse<dynamic>> orderDetails(
      {OrderDetailModel orderDetailModel,
      List<ProductModel> productModel}) async {
    final OrderList orderList = OrderList(
      List<OrderProduct>.generate(
        productModel.length,
        (int index) {
          return OrderProduct(
            productId: productModel[index].productId,
            quantity: productModel[index].quantity,
          );
        },
      ),
    );
    final String requestBody = json.encoder.convert(orderList);
    print(requestBody);
    final http.Response response =
        await http.post('https://api.fagnum.com/ecom-store/order-submit',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "name": orderDetailModel.name,
              "area": orderDetailModel.area,
              "city": orderDetailModel.city,
              "companyId": companyId,
              "contactNumber": orderDetailModel.contactNumber,
              "contestName": orderDetailModel.contestName,
              "country": orderDetailModel.country,
              "emailId": orderDetailModel.emailId,
              "houseNo": orderDetailModel.houseNo,
              "orderId": orderDetailModel.orderId,
              "paymentOption": orderDetailModel.paymentOption,
              "paymentOrderId": orderDetailModel.paymentOrderId,
              "referralCode": orderDetailModel.referralCode,
              "state": orderDetailModel.state,
              "products": requestBody
            }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to save data');
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (responseMap["status"]) {
        print(responseMap["status"]);
        throw Exception('Failed to load data models');
      } else {
        return ApiResponse.fromMap(responseMap);
      }
    }
  }

  Future<ApiResponse<dynamic>> getInventory(String value) async {
    final http.Response response = await http.post(
        'http://145.239.92.37:8080/fagnum-test-api/ecom-inventory/search',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "param": "item",
          "companyId": companyId,
          "value": value
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 204) {
      throw Error();
    }
    if (response.statusCode != 200) {
      throw Exception('Failed to save data');
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (responseMap["status"]) {
        print(responseMap["status"]);
        throw Exception('Failed to load data models');
      } else {
        return ApiResponse.fromMap(responseMap);
      }
    }
  }

  Future<ApiResponse<dynamic>> getProduct(String value) async {
    final http.Response response = await http.post(
        'http://145.239.92.37:8080/fagnum-test-api/product/search',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "param": "name",
          "companyId": companyId,
          "value": value
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 204) {
      throw Error();
    }
    if (response.statusCode != 200) {
      throw Exception('Failed to save data');
    } else {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (responseMap["status"]) {
        print(responseMap["status"]);
        throw Exception('Failed to load data models');
      } else {
        return ApiResponse.fromMap(responseMap);
      }
    }
  }
}
