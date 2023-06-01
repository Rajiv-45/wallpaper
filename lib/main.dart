import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaperhubapp/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wallpaperhub',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
