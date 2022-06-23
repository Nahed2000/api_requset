import 'dart:io';

import 'package:api_first/model/api_response.dart';
import 'package:api_first/storge/pref_controller.dart';

mixin ApiHelper {
  Map<String, String> get headers {
    Map<String, String> headers = <String, String>{};
    headers[HttpHeaders.acceptHeader] = 'application/json';
    if (SharedPrefController().isLogin) {
      headers[HttpHeaders.authorizationHeader] = SharedPrefController().token;
    }
    return headers;
  }
  ApiResponse<T> getGenericError<T>(){
    return ApiResponse<T>(message: 'Something is wrong ,try again .. ', status: false);
}
  ApiResponse get errorServer =>
      ApiResponse(message: 'Something is wrong ,try again .. ', status: false);
}
