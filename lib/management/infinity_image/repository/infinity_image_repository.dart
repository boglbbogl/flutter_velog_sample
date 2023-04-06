import 'dart:convert';
import 'dart:io';
import 'package:flutter_velog_sample/management/infinity_image/model/infinity_image_model.dart';
import 'package:http/http.dart' as http;

class InfinityImageRepository {
  static final InfinityImageRepository instance =
      InfinityImageRepository._internal();
  factory InfinityImageRepository() => instance;
  InfinityImageRepository._internal();

  Future<List<InfinityImageModel>?> fetchHorizotalImages({
    required int pageNo,
  }) async {
    try {
      http.Response _response = await http.get(
          Uri.parse("https://picsum.photos/v2/list?page=$pageNo&limit=10"));
      if (_response.statusCode == 200) {
        List<dynamic> _fromData = json.decode(_response.body) as List<dynamic>;
        List<InfinityImageModel> _data = _fromData
            .map((e) => InfinityImageModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return _data;
      }
      return null;
    } on HttpException {
      return null;
    } catch (error) {
      return null;
    }
  }

  Future<List<InfinityImageModel>?> fetchVerticalImages({
    required int pageNo,
  }) async {
    try {
      http.Response _response = await http.get(
          Uri.parse("https://picsum.photos/v2/list?page=$pageNo&limit=10"));
      if (_response.statusCode == 200) {
        List<dynamic> _fromData = json.decode(_response.body) as List<dynamic>;
        List<InfinityImageModel> _data = _fromData
            .map((e) => InfinityImageModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return _data;
      }
      return null;
    } on HttpException {
      return null;
    } catch (error) {
      return null;
    }
  }
}
