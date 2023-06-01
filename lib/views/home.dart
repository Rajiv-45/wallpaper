import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaperhubapp/data/data.dart';
import 'package:wallpaperhubapp/model/wallpaper_model.dart';
import 'package:wallpaperhubapp/views/home_vm.dart';
import 'package:wallpaperhubapp/views/image.dart';
import 'package:wallpaperhubapp/views/search.dart';
import 'package:wallpaperhubapp/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import '../model/categories_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // @override
  // void initState() {

  //   super.initState();
  // }
  HomeVM vm = Get.put(HomeVM());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: GetBuilder<HomeVM>(builder: (vm) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: const Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: vm.searchItem,
                        decoration: const InputDecoration(
                            hintText: "search wallpaper",
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          vm.search(type: vm.searchItem.text);
                          Get.to(() => SearchItems());
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: vm.categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                        title: vm.categories[index].categorieName,
                        imgUrl: vm.categories[index].imgUrl,
                      );
                    }),
              ),
              vm.isDataLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 220.0 * vm.wallpaperModel.length / 2,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ImageCard(
                                        i: 2 * i,
                                        wallpaperModel:
                                            vm.wallpaperModel[2 * i]),
                                    ImageCard(
                                        i: 2 * i + 1,
                                        wallpaperModel:
                                            vm.wallpaperModel[2 * i + 1]),
                                  ],
                                ));
                          },
                          separatorBuilder: (context, i) {
                            return const SizedBox(height: 20);
                          },
                          itemCount: vm.wallpaperModel.length ~/ 2)),
              vm.isDataLoading
                  ? SizedBox()
                  : vm.isLoadMore
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              vm.loadMoreData();
                            },
                            child: Text("Load More",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
              SizedBox(height: 10),
            ],
          ),
        );
      }),
    );
  }
}

class ImageCard extends StatelessWidget {
  WallpaperModel wallpaperModel;
  int i;
  ImageCard({
    Key? key,
    required this.wallpaperModel,
    required this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.45,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => Get.to(() => ImageDes(wallpaperModel: wallpaperModel)),
        child: Hero(
          tag: i.toString(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              wallpaperModel.src?.portrait ??
                  " https://images.pexels.com/photos/2050994/pexels-photo-2050994.jpeg",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;
  const CategoriesTile({super.key, required this.title, required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeVM>(builder: (vm) {
      return InkWell(
        onTap: () {
          vm.cateroryType = title;
          vm.update();
          vm.getTrendingWallpapers(type: title);
        },
        child: Container(
          margin: const EdgeInsets.only(right: 4),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imgUrl,
                    height: 50,
                    width: 100,
                    fit: BoxFit.cover,
                  )),
              Container(
                color: Colors.black26,
                height: 50,
                width: 100,
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
