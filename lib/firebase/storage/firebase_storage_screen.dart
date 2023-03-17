import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class _FeedImageModel {
  final String url;
  final String path;
  const _FeedImageModel({required this.url, required this.path});
  factory _FeedImageModel.fromFirestore(Map<String, dynamic> json) {
    return _FeedImageModel(
      url: json["url"],
      path: json["path"],
    );
  }
  Map<String, dynamic> toFirestore() => {
        "url": url,
        "path": path,
      };
}

class _FeedModel {
  final String userKey;
  final List<_FeedImageModel> images;
  final Timestamp dateTime;
  const _FeedModel({
    required this.userKey,
    required this.images,
    required this.dateTime,
  });
  factory _FeedModel.fromFirestore(Map<String, dynamic> json) {
    return _FeedModel(
      userKey: json["userKey"],
      images: (json["images"] as List<dynamic>)
          .map((e) => _FeedImageModel.fromFirestore(e))
          .toList(),
      dateTime: json["dateTime"],
    );
  }
  Map<String, dynamic> toFirestore() => {
        "userKey": userKey,
        "images": images
            .map((e) => _FeedImageModel(url: e.url, path: e.path).toFirestore())
            .toList(),
        "dateTime": dateTime,
      };
}

class FirebaseStorageScreen extends StatefulWidget {
  const FirebaseStorageScreen({super.key});

  @override
  State<FirebaseStorageScreen> createState() => _FirebaseStorageScreenState();
}

class _FirebaseStorageScreenState extends State<FirebaseStorageScreen> {
  List<_FeedImageModel> feedImages = [];
  final String _userKey = "123456789";
  bool _isUpload = false;

  Future<List<_FeedImageModel>> _imagePickerToUpload() async {
    setState(() {
      _isUpload = true;
    });
    List<_FeedImageModel> _imageUrls = [];
    if (Platform.isIOS) {
      await Permission.photosAddOnly.request();
    }

    final String _dateTime = DateTime.now().millisecondsSinceEpoch.toString();
    ImagePicker _picker = ImagePicker();
    List<XFile> _images = await _picker.pickMultiImage();
    for (int i = 0; i < _images.length; i++) {
      String _imageRef = "feed/${_userKey}_${_dateTime}_$i";
      File _file = File(_images[i].path);
      await FirebaseStorage.instance.ref(_imageRef).putFile(_file);
      final String _urlString =
          await FirebaseStorage.instance.ref(_imageRef).getDownloadURL();
      _imageUrls.add(_FeedImageModel(url: _urlString, path: _imageRef));
    }
    return _imageUrls;
  }

  Future<String?> _toFirestore(List<_FeedImageModel> images) async {
    try {
      DocumentReference<Map<String, dynamic>> _reference =
          FirebaseFirestore.instance.collection("feed").doc();
      await _reference.set(_FeedModel(
              userKey: _userKey, images: images, dateTime: Timestamp.now())
          .toFirestore());
      return null;
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  Future<void> _getFeed({bool isRefresh = false}) async {
    if (isRefresh) {
      feedImages.clear();
    }
    QuerySnapshot<Map<String, dynamic>> _snapshot = await FirebaseFirestore
        .instance
        .collection("feed")
        .orderBy("dateTime", descending: true)
        .get();
    List<_FeedModel> _data =
        _snapshot.docs.map((e) => _FeedModel.fromFirestore(e.data())).toList();
    for (final e in _data) {
      feedImages.addAll(e.images);
    }
    setState(() {
      feedImages = feedImages;
    });
  }

  Future<void> deleteImage(_FeedImageModel data) async {
    // await FirebaseStorage.instance.ref(data.path).delete();
    // QuerySnapshot<Map<String, dynamic>> _data = await FirebaseFirestore.instance
    //     .collection("feed")
    //     .where(data, isEqualTo: true)
    //     .get();
  }

  @override
  void initState() {
    _getFeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: appBar(title: "Firebase Storage"),
            floatingActionButton: SizedBox(
              height: 100,
              child: Column(
                children: [
                  _button(
                      icon: Icons.refresh_outlined,
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        _getFeed(isRefresh: true);
                      }),
                  const SizedBox(height: 10),
                  _button(
                      icon: Icons.add_circle_outline_outlined,
                      onTap: () async {
                        HapticFeedback.mediumImpact();
                        List<_FeedImageModel> _images =
                            await _imagePickerToUpload();
                        String? _error = await _toFirestore(_images);
                        if (_error != null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(_error)));
                        }
                        setState(() {
                          _isUpload = false;
                        });
                      })
                ],
              ),
            ),
            body: GridView.builder(
                itemCount: feedImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      HapticFeedback.mediumImpact();
                      logger.e(feedImages[index]);
                    },
                    child: Container(
                      width: MediaQueryData.fromWindow(window).size.width,
                      height: MediaQueryData.fromWindow(window).size.width,
                      color: const Color.fromRGBO(115, 115, 115, 1),
                      child: Image.network(
                        feedImages[index].url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                })),
        if (_isUpload) ...[
          Container(
            width: MediaQueryData.fromWindow(window).size.width,
            height: MediaQueryData.fromWindow(window).size.height,
            color: Colors.black38,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Container _button({
    required IconData icon,
    required Function() onTap,
  }) {
    return Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.black45,
        ),
        child: IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              color: Colors.white,
            )));
  }
}
