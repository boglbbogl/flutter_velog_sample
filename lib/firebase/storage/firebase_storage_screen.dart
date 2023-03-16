import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseStorageScreen extends StatefulWidget {
  const FirebaseStorageScreen({super.key});

  @override
  State<FirebaseStorageScreen> createState() => _FirebaseStorageScreenState();
}

class _FirebaseStorageScreenState extends State<FirebaseStorageScreen> {
  Future<File?> _fetchNetworkToFile() async {
    try {
      http.Response _response = await http
          .get(Uri.parse("https://picsum.photos/seed/picsum/200/300"));
      if (_response.statusCode == 200) {
        Uint8List _unit8List = _response.bodyBytes;
        ByteData _byte = ByteData.view(_unit8List.buffer);
        Directory _systemDirectory = Directory.systemTemp;
        File _file = await File('${_systemDirectory.path}/picsum').writeAsBytes(
            _unit8List.buffer
                .asUint8List(_byte.offsetInBytes, _byte.lengthInBytes));
        return _file;
      } else {
        return null;
      }
    } on HttpException catch (error) {
      logger.e(error);
      return null;
    }
  }

  Future<Uint8List?> _fetchNetworkToUint8List() async {
    try {
      http.Response _response =
          await http.get(Uri.parse("https://picsum.photos/200/300/?blur"));
      if (_response.statusCode == 200) {
        Uint8List _unit8List = _response.bodyBytes;
        return _unit8List;
      } else {
        return null;
      }
    } on HttpException catch (error) {
      logger.e(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Firebase Storage"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () async {
                logger.e("message");
                if (Platform.isIOS) {
                  await Permission.photosAddOnly.request();
                }
                ImagePicker _picker = ImagePicker();
                XFile? _pick =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (_pick != null) {
                  // File _file = File(_pick.path);
                  Uint8List _bytes = await _pick.readAsBytes();
                  FirebaseStorage.instance
                      .ref("test/picker/test_picker")
                      .putData(
                        _bytes,
                        SettableMetadata(
                          contentType: "image/jpeg",
                        ),
                      );
                }

                // if (_image != null) {
                //   logger.e(_image.name);
                // }
              },
              child: Text("Click")),
        ],
      ),
    );
  }
}
