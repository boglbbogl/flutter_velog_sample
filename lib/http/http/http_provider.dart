import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_model/piscum_photo_model.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:http/http.dart' as http;

class HttpProvider extends ChangeNotifier {
  List<PiscumPhotoModel> photos = [];

  int currentPageNo = 0;
  bool isAdd = false;

  Future<void> started() async {
    await _getPhotos();
  }

  void scrollListerner(ScrollUpdateNotification notification) {
    if (notification.metrics.maxScrollExtent * 0.85 <
        notification.metrics.pixels) {
      _morePhotos();
    }
  }

  Future<void> _morePhotos() async {
    if (!isAdd) {
      isAdd = true;
      List<PiscumPhotoModel>? _data = await _fetchPost(pageNo: currentPageNo);
      photos.addAll(_data);
      currentPageNo = currentPageNo + 1;
      isAdd = false;
      notifyListeners();
    }
  }

  Future<void> _getPhotos() async {
    List<PiscumPhotoModel>? _data = await _fetchPost(pageNo: currentPageNo);
    photos = _data;
    currentPageNo = 1;
    notifyListeners();
  }

  Future<List<PiscumPhotoModel>> _fetchPost({
    required int pageNo,
  }) async {
    try {
      http.Response _response = await http.get(
          Uri.parse("https://picsum.photos/v2/list?page=$pageNo&limit=24"));
      if (_response.statusCode == 200) {
        List<dynamic> _data = json.decode(_response.body);
        List<PiscumPhotoModel> _result =
            _data.map((e) => PiscumPhotoModel.fromJson(e)).toList();
        return _result;
      } else {
        return [];
      }
    } catch (error) {
      logger.e(error);
      return [];
    }
  }
}
