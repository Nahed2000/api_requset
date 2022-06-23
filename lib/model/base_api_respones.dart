import 'package:api_first/model/user_api.dart';

class BaseApiResponse {
  late bool status;
  late String message;
  late List<User> data;

  BaseApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((jsonObject) {
        data.add(User.fromJson(jsonObject));
      });
    }
  }
}
