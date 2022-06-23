import 'package:api_first/api/api_settings.dart';
import 'package:api_first/get/image_getx_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  ImagesGetXController controller = Get.put(ImagesGetXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/update_images_screen'),
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
                child:  CircularProgressIndicator(),
              );
            }
            else if (controller.images.isNotEmpty) {
              return GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  return  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: CachedNetworkImage(

                      fit: BoxFit.cover,
                      imageUrl: ApiSettings.imageApiUrl + controller.images[index].image,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  );
                },
              );
            }
            else {
              return const Center(child: Text('No Data '));
            }
          },
        ));
  }
}
