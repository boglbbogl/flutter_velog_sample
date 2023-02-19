import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_model/piscum_photo_model.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:get/get.dart';

class HttpWithDioGetx extends GetxController {
  final Dio _dio = Dio();
  ScrollController scrollController = ScrollController();
  List<PiscumPhotoModel> photos = [];
  int currentPageNo = 1;
  bool isAdd = false;

  Future<void> started() async {
    await _getPhotos();
  }

  Future<void> _morePhotos() async {
    if (!isAdd) {
      isAdd = true;
      update();
      List<PiscumPhotoModel> _data = await _fetchPost(pageNo: currentPageNo);
      Future.delayed(const Duration(milliseconds: 1000), () {
        photos.addAll(_data);
        currentPageNo = currentPageNo + 1;
        isAdd = false;
        update();
      });
    }
  }

  Future<void> _getPhotos() async {
    photos = await _fetchPost(pageNo: currentPageNo);
    currentPageNo = 2;
    update();
  }

  Future<List<PiscumPhotoModel>> _fetchPost({
    required int pageNo,
  }) async {
    try {
      final _response =
          await _dio.get("https://picsum.photos/v2/list?page=$pageNo&limit=10");
      if (_response.statusCode == 200) {
        List<dynamic> _fromData = _response.data as List<dynamic>;
        List<PiscumPhotoModel> _data = _fromData
            .map((e) => PiscumPhotoModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return _data;
      } else {
        return [];
      }
    } catch (error) {
      logger.e(error);
      return [];
    }
  }

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent * 0.85 <
          scrollController.position.pixels) {
        _morePhotos();
      }
    });
    super.onInit();
  }
}
