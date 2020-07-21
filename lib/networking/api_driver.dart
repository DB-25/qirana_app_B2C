import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qirana_app/networking/ApiResponse.dart';

class ApiDriver {
  final String baseUrl = 'https://api.fagnum.com/ecom-store/';
  final String companyId = 'ff80818171b2ad0501720ab097fd0006';

  Future<ApiResponse<dynamic>> getData(String type) async {
    final http.Response response = await http.get(
      baseUrl + type + '?companyId=' + companyId,
    );
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
}

//  Future<List<DataModel>> read() async {
//    final prefs = await SharedPreferences.getInstance();
//    final response = await http.post(
//      baseUrl + 'classes/read',
//      headers: <String, String>{
//        'Content-Type': 'application/json; charset=UTF-8',
//        'Authorization': "Bearer " + prefs.getString('accessToken'),
//      },
//      body: jsonEncode(<String, String>{
//        'companyId': companyId,
//        'emailId': prefs.getString('emailId'),
//      }),
//    );
//    //final response = await http.get('http://145.239.92.37:8080/fagnum-api/feeder/read');
//    print(response.statusCode);
//    print(response.body);
//    if (response.statusCode != 200) {
//      throw Exception('Failed to load data model');
//    } else {
//      Map<String, dynamic> responseMap = jsonDecode(response.body);
//      if (!responseMap['status']) {
//        throw Exception('Failed to load data model');
//      } else {
//        List<DataModel> dataModelList = [];
//        for (var dataModel in responseMap['data']) {
//          dataModelList.add(DataModel.fromMap(dataModel));
//        }
//        return dataModelList;
//      }
//    }
//  }
