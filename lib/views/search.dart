import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaperhubapp/views/home.dart';
import 'package:wallpaperhubapp/views/home_vm.dart';

class SearchItems extends StatelessWidget {
  const SearchItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeVM>(builder: (vm) {
      return Scaffold(
        appBar: AppBar(
          title: Text(vm.searchItem.text),
          elevation: 0,
        ),
        body: vm.isSearchLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, i) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImageCard(
                              i: 2 * i, wallpaperModel: vm.searchList[2 * i]),
                          ImageCard(
                              i: 2 * i + 1,
                              wallpaperModel: vm.searchList[2 * i + 1]),
                        ],
                      ));
                },
                separatorBuilder: (context, i) {
                  return const SizedBox(height: 20);
                },
                itemCount: vm.searchList.length ~/ 2),
      );
    });
  }
}
