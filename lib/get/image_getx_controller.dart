import 'dart:convert';
import 'dart:io';

import 'package:api_first/api/controller/images_api_controller.dart';
import 'package:api_first/model/api_response.dart';
import 'package:api_first/model/student_image.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

typedef UploadImageCallBack = void Function(ApiResponse apiResponse);

class ImagesGetXController extends GetxController {
  static ImagesGetXController get to => Get.find();
  RxList<StudentImage> images = <StudentImage>[].obs;
  RxBool loading = false.obs ;

  final ImagesApiController _apiController = ImagesApiController();

  @override
  void onInit() {
    readImage();
    // TODO: implement onInit
    super.onInit();
  }
    void readImage()async{
    loading.value = true;
    ApiResponse<StudentImage> apiResponse = await _apiController.indexImage();
    loading.value = false;
    if(apiResponse.status) images.value = apiResponse.data??[];
    }

  Future<void> uploadImage({
    required File file,
    required UploadImageCallBack uploadImageCallBack,
  }) async {
    StreamedResponse streamedResponse =
        await _apiController.uploadImages(file: file);
    streamedResponse.stream.transform(utf8.decoder).listen((String body) {
      if (streamedResponse.statusCode == 201) {
        var jsonResponse = jsonDecode(body);
        StudentImage studentImage =
            StudentImage.fromJson(jsonResponse['object']);
        images.add(studentImage);
         uploadImageCallBack(ApiResponse(
          message: jsonResponse['message'],
          status: jsonResponse['status'],
        ));
      }else{
        print(body);
        print(streamedResponse.statusCode);
        uploadImageCallBack(ApiResponse(message:'Error' ,status: false));
      }
    });
  }
  Future<ApiResponse>deleteImage({required int index})async{
    ApiResponse apiResponse = await _apiController.deleteImages(id : images[index].id);
    if(apiResponse.status){
      images.removeAt(index);
    }
    return apiResponse;
  }
}
