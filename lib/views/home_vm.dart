import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wallpaperhubapp/data/data.dart';
import 'package:wallpaperhubapp/model/categories_model.dart';
import 'package:wallpaperhubapp/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;

class HomeVM extends GetxController {
  bool isDataLoading = false;
  bool isSearchLoading = false;
  bool isLoadMore = false;
  TextEditingController searchItem = TextEditingController();

  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpaperModel = [];
  List<WallpaperModel> searchList = [];
  String cateroryType = "people";
  int pageNo = 2;
  // List<WallpaperModel> wallpapers = [];
  loadMoreData() async {
    isLoadMore = true;
    update();
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=${cateroryType}&per_page=20&page=$pageNo"),
        headers: {"Authorization": apiKey});
    //print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    debugPrint(jsonData.toString());
    jsonData["photos"].forEach((element) {
      print(element);
      wallpaperModel.add(WallpaperModel.fromMap(element));
    });
    isLoadMore = false;
    pageNo = pageNo + 1;
    update();
  }

  getTrendingWallpapers({required String type}) async {
    isDataLoading = true;
    update();
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=${type}&per_page=20"),
        headers: {"Authorization": apiKey});
    //print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    debugPrint(jsonData.toString());
    wallpaperModel = [];
    jsonData["photos"].forEach((element) {
      print(element);
      wallpaperModel.add(WallpaperModel.fromMap(element));
    });
    debugPrint("sedcfgvbhnjhgvfcdcfgvbh");
    debugPrint(wallpaperModel[0].src!.original.toString());
    debugPrint(wallpaperModel.length.toString());
    isDataLoading = false;
    update();
  }

  search({required String type}) async {
    isSearchLoading = true;
    update();
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=${type}&per_page=40"),
        headers: {"Authorization": apiKey});
    //print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    debugPrint(jsonData.toString());
    searchList = [];
    jsonData["photos"].forEach((element) {
      print(element);
      searchList.add(WallpaperModel.fromMap(element));
    });
    debugPrint("sedcfgvbhnjhgvfcdcfgvbh");

    isSearchLoading = false;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getTrendingWallpapers(type: "people");
    categories = getCategories();
    super.onInit();
  }

  saveImage(String imageUrl) async {
    var response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: DateTime.now().toString());
    print(result);
  }
}
