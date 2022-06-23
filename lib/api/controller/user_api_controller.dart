import 'dart:convert';

import 'package:api_first/api/api_settings.dart';
import 'package:api_first/model/base_api_respones.dart';
import 'package:http/http.dart' as http;

import '../../model/user_api.dart';
  
class UserApiController {
  Future<List<User>> reedUser() async {
    var uri = Uri.parse(ApiSettings.reedUser);
    var response = await http.get(uri);
    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
     // BaseApiResponse baseApiResponse = BaseApiResponse.fromJson(jsonResponse);
     // return baseApiResponse.data;
      var jsonData = jsonResponse['data'] as List;
      List<User> users = jsonData.map((elementJson) => User.fromJson(elementJson)).toList();
      return users;
    }
    return [];
  }
}
