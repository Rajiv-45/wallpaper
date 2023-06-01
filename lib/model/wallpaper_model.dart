// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

class WallpaperModel {
  String? photographer;
  String? photographer_url;
  int? photographer_id;
  SrcModel? src;

  WallpaperModel(
      {this.src,
      this.photographer_url,
      this.photographer_id,
      this.photographer});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
        src: jsonData["src"] != null ? SrcModel.fromMap(jsonData["src"]) : null,
        photographer_url: jsonData["photographer_url"],
        photographer_id: jsonData["photographer_id"],
        photographer: jsonData["photographer"]);
  }
}

class SrcModel {
  String? original;
  String? small;
  String? portrait;
  SrcModel({this.original, this.small, this.portrait});
  factory SrcModel.fromMap(Map<String, dynamic> json) {
    return SrcModel(
        original: json["original"],
        small: json["small"],
        portrait: json["portrait"]);
  }
}
