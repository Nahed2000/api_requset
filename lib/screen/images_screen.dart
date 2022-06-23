import 'package:api_first/api/api_settings.dart';
import 'package:api_first/get/image_getx_controller.dart';
import 'package:api_first/model/api_response.dart';
import 'package:api_first/utils/Helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> with Helper{
  ImagesGetXController controller = Get.put(ImagesGetXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black
          ),
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/upload_images_screen'),
              icon: const Icon(Icons.camera_alt_outlined),
            )
          ],
          actionsIconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Images',
            style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600, fontSize: 22, color: Colors.black),
          ),
        ),
        body: GetX<ImagesGetXController>(
          builder: (controller) {
            if (controller.loading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.images.isNotEmpty) {
              return GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          cacheKey: controller.images[index].image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: ApiSettings.imageApiUrl +
                              controller.images[index].image,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.black45,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.images[index].image,
                                    style: GoogleFonts.nunito(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async=>await deleteImage(index: index),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No Data '));
            }
          },
        ));
  }
  Future<void>deleteImage({required int index})async{
    ApiResponse apiResponse = await controller.deleteImage(index: index);
    showSnackBar(context, message: 'Success Image Deleted ', status: !apiResponse.status);
  }
}
