import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class _FeedModel {
  final String uid;
  final String docId;
  final String image;
  final String path;
  final Timestamp dateTime;

  const _FeedModel({
    required this.uid,
    required this.docId,
    required this.image,
    required this.path,
    required this.dateTime,
  });
  factory _FeedModel.fromFirestore(Map<String, dynamic> json) {
    return _FeedModel(
      uid: json["uid"],
      docId: json["docId"],
      image: json["image"],
      path: json["path"],
      dateTime: json["dateTime"],
    );
  }
  Map<String, dynamic> toFirestore() => {
        "uid": uid,
        "docId": docId,
        "image": image,
        "path": path,
        "dateTime": dateTime,
      };
}

class FirebaseStorageScreen extends StatefulWidget {
  const FirebaseStorageScreen({super.key});

  @override
  State<FirebaseStorageScreen> createState() => _FirebaseStorageScreenState();
}

class _FirebaseStorageScreenState extends State<FirebaseStorageScreen> {
  List<_FeedModel> _feed = [];
  final String _uid = "123456789";
  bool _isUpload = false;

  Future<Map<String, String>?> _imagePickerToUpload() async {
    setState(() {
      _isUpload = true;
    });
    if (Platform.isIOS) {
      await Permission.photosAddOnly.request();
    }
    final String _dateTime = DateTime.now().millisecondsSinceEpoch.toString();
    ImagePicker _picker = ImagePicker();
    XFile? _images = await _picker.pickImage(source: ImageSource.gallery);
    if (_images != null) {
      String _imageRef = "feed/${_uid}_$_dateTime";
      File _file = File(_images.path);
      await FirebaseStorage.instance.ref(_imageRef).putFile(_file);
      final String _urlString =
          await FirebaseStorage.instance.ref(_imageRef).getDownloadURL();
      return {
        "image": _urlString,
        "path": _imageRef,
      };
    } else {
      return null;
    }
  }

  Future<void> _toFirestore(Map<String, String> images) async {
    try {
      DocumentReference<Map<String, dynamic>> _reference =
          FirebaseFirestore.instance.collection("feed").doc();
      await _reference.set(_FeedModel(
        uid: _uid,
        docId: _reference.id,
        image: images["image"].toString(),
        path: images["path"].toString(),
        dateTime: Timestamp.now(),
      ).toFirestore());
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message ?? "")));
    }
  }

  Future<void> _getFeed({bool isRefresh = false}) async {
    if (isRefresh) {
      _feed.clear();
    }
    QuerySnapshot<Map<String, dynamic>> _snapshot = await FirebaseFirestore
        .instance
        .collection("feed")
        .orderBy("dateTime", descending: true)
        .get();
    setState(() {
      _feed = _snapshot.docs
          .map((e) => _FeedModel.fromFirestore(e.data()))
          .toList();
    });
  }

  Future<void> _deleteFeed(_FeedModel data) async {
    await FirebaseStorage.instance.ref(data.path).delete();
    await FirebaseFirestore.instance
        .collection("feed")
        .doc(data.docId)
        .delete();
    setState(() {
      _feed.remove(data);
    });
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
                        Map<String, String>? _images =
                            await _imagePickerToUpload();
                        if (_images != null) {
                          await _toFirestore(_images);
                        }
                        setState(() {
                          _isUpload = false;
                        });
                      })
                ],
              ),
            ),
            body: GridView.builder(
                itemCount: _feed.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () async {
                      HapticFeedback.mediumImpact();
                      await _deleteFeed(_feed[index]);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      color: const Color.fromRGBO(115, 115, 115, 1),
                      child: Image.network(
                        _feed[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                })),
        if (_isUpload) ...[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
