import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_velog_sample/main.dart';
import 'package:http/http.dart' as http;

class ChangedImageRepository {
  static final ChangedImageRepository instance =
      ChangedImageRepository._internal();
  factory ChangedImageRepository() => instance;
  ChangedImageRepository._internal();

  Future<String?> fetchImage() async {
    try {
      http.Response _response =
          await http.get(Uri.parse("https://picsum.photos/id/237/200/300"));
      if (_response.statusCode == 200) {
        Map<String, dynamic> _data = json.decode(_response.body);
        logger.e(_data);
      }
    } on HttpException catch (error) {
      return null;
    }
  }
}
