import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaperhubapp/model/wallpaper_model.dart';
import 'package:wallpaperhubapp/views/home_vm.dart';

class ImageDes extends StatelessWidget {
  WallpaperModel wallpaperModel;
  ImageDes({super.key, required this.wallpaperModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeVM>(builder: (vm) {
      return Scaffold(
        body: Stack(
          children: [
            Hero(
              tag: wallpaperModel.photographer_id.toString(),
              child: Container(
                width: Get.height,
                height: Get.height,
                child: Image.network(wallpaperModel.src!.portrait!,
                    fit: BoxFit.cover),
              ),
            ),
            Positioned(
                bottom: 41,
                child: Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    child: Container(
                      width: Get.width * 0.5,
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 2, color: Colors.grey),
                          gradient: const LinearGradient(
                              colors: [Color(0x0fffffff), Color(0x36ffffff)])),
                      height: 50,
                    ))),
            Positioned(
                bottom: 20,
                child: InkWell(
                  onTap: () {
                    vm.saveImage(wallpaperModel.src!.portrait.toString());
                  },
                  child: Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          width: Get.width * 0.5,
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(width: 2, color: Colors.grey),
                              gradient: const LinearGradient(colors: [
                                Color(0x36ffffff),
                                Color(0x0fffffff)
                              ])),
                          height: 50,
                          child: Column(
                            children: const [
                              Text("Set Wallpaper",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 5),
                              Text("Image will be saved in gallery",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        InkWell(
                          onTap: () => Get.back(),
                          child: const Text("Cancel",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              )),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      );
    });
  }
}
