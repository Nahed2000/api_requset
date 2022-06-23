//Upload   ,, Delete ,,,     Read

import 'dart:convert';
import 'dart:io';

import 'package:api_first/api/api_helper.dart';
import 'package:api_first/api/api_settings.dart';
import 'package:api_first/model/api_response.dart';
import 'package:api_first/model/student_image.dart';
import 'package:api_first/storge/pref_controller.dart';
import 'package:http/http.dart' as http;

class ImagesApiController with ApiHelper {
  Future<http.StreamedResponse> uploadImages({required File file}) async {
    var url = Uri.parse(ApiSettings.images.replaceFirst('/{id}', 'to'));
    var request = http.MultipartRequest('POST', url);

    //TODO: File
    var imageFile = await http.MultipartFile.fromPath('image', file.path);
    request.files.add(imageFile);
    //TODO: Text  --
    //request.fields['name'] = 'ABC';
    //request.fields['_method']= 'PUT';   // في حال المبرمج حاط الميثود انه put
    //TODO: Headers
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    request.headers[HttpHeaders.authorizationHeader] =
        SharedPrefController().token;

    return request.send();
  }

  Future<ApiResponse<StudentImage>> indexImage() async {
    var url = Uri.parse(ApiSettings.images.replaceFirst('/{id}', 'to'));
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 400) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var jsonArray = jsonResponse['data'] as List;
        List<StudentImage> listImage = jsonArray
            .map((jsonObject) => StudentImage.fromJson(jsonObject))
            .toList();
        return ApiResponse.listImage(
            message: jsonResponse['message'],
            status: jsonResponse['status'],
            data: listImage);
      }
      return ApiResponse(message: 'you must Login again ', status: false);
    }
    return getGenericError();
  }

  Future<ApiResponse> deleteImages({required int id}) async {
    var url = Uri.parse(ApiSettings.images.replaceFirst('{id}', id.toString()));
    var response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    if (response.statusCode == 404 || response.statusCode == 401) {
      String message = response.statusCode == 404
          ? 'Selected Image not found'
          : 'Unauthorized Image, login again';
      return ApiResponse(message: message, status: false);
    }
    return errorServer;
  }
}
