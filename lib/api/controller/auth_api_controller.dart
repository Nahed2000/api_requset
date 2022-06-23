import 'dart:async';
import 'dart:convert';

import 'package:api_first/api/api_settings.dart';
import 'package:api_first/model/api_response.dart';
import 'package:api_first/model/student_api.dart';
import 'package:api_first/storge/pref_controller.dart';
import 'package:http/http.dart' as http;

import '../api_helper.dart';

class AuthApiController with ApiHelper {
  Future<ApiResponse> loginUser(
      {required String email, required String password}) async {
    var url = Uri.parse(ApiSettings.loginUser);
    var response = await http.post(url, body: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var jsonObject = jsonResponse['object'];
        Student student = Student.fromJson(jsonObject);
        SharedPrefController().save(student: student);
      }
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    } else {
      return errorServer;
    }
  }
  Future<ApiResponse> logout() async {
    var url = Uri.parse(ApiSettings.logout);
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      var jsonResponse = jsonDecode(response.body);
      unawaited(SharedPrefController().clear());
      if (response.statusCode == 200) {
        return ApiResponse(
            message: jsonResponse['message'], status: jsonResponse['status']);
      } else {
        return ApiResponse(message: 'Logged out Successfully', status: true);
      }
    }
    return errorServer;
  }

  Future<ApiResponse> register({required Student student}) async {
    var url = Uri.parse(ApiSettings.register);
    var response = await http.post(url, body: {
      'full_name': student.fullName,
      'email': student.email,
      'password': student.password,
      'gender': student.gender,
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return errorServer;
  }

  Future<ApiResponse> forGetPassword({required String email}) async {
    var url = Uri.parse(ApiSettings.forGetPassword);
    var response = await http.post(url, body: {'email': email});

    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(jsonResponse['code']);
      }
      print('04');
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return errorServer;
  }

  Future<ApiResponse> resetPassword(
      {required String email,
      required String password,
      required String code}) async {
    var url = Uri.parse(ApiSettings.resetPassword);
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
      'password_confirmation': password,
      'code': code
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return errorServer;
  }
}
