import 'dart:io';

import 'package:api_first/get/image_getx_controller.dart';
import 'package:api_first/model/api_response.dart';
import 'package:api_first/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> with Helper {
  //TODO : Create XFile variable which will hold  Selected/upload images

  XFile? pikedImage; // this is the image that we will upload
//TODO : Create instance from ImagePicker
  late ImagePicker _imagePicker;

  //Todo : create value variable for progressIndicator

  double? _progressValue = 0;

  @override
  void initState() {
    _imagePicker = ImagePicker();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Upload Images',
          style: GoogleFonts.nunito(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 5,
            backgroundColor: Colors.green.shade100,
            color: Colors.green,
            value: _progressValue,
          ),
          Expanded(
            child: pikedImage == null
                ? IconButton(
                    iconSize: 48,
                    onPressed: () async => await _pikeImage(),
                    icon: const Icon(Icons.camera_alt_outlined),
                  )
                : Image.file(File(pikedImage!.path)),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.cloud_upload_outlined),
            label: Text(
              'Upload Image',
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pikeImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        pikedImage = image;
      });
    }
  }

  Future<void> performUploadImage() async {
    if (_checkData()) {
      await _uploadImage();
    }
  }

  bool _checkData() {
    if (pikedImage != null) {
      return true;
    }
    showSnackBar(context, message: 'Pick Image to Upload', status: true);
    return false;
  }

  Future<void> _uploadImage() async {
    updateProgressChange();
    await ImagesGetXController.to.uploadImage(
        file: File(pikedImage!.path),
        uploadImageCallBack: (ApiResponse apiResponse) {
          updateProgressChange(value: apiResponse.status?1:0);
          showSnackBar(
            context,
            message: apiResponse.message,
            status: !apiResponse.status,
          );
        });
  }

  void updateProgressChange({double? value}) {
    setState(() {
      _progressValue = value;
    });
  }
}
