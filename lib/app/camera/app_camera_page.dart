import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/app/camera/app_camera_image_page.dart';
import 'package:flutter_velog_sample/app/camera/app_camera_video_page.dart';

class AppCameraPage extends StatelessWidget {
  const AppCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Camera App"),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              HapticFeedback.mediumImpact();
              List<CameraDescription> descriptions = await availableCameras();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => AppCameraImagePage(descriptions)));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 24, bottom: 24),
              width: MediaQuery.of(context).size.width,
              child: const Icon(
                Icons.camera_alt_rounded,
                size: 48,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              HapticFeedback.mediumImpact();
              List<CameraDescription> descriptions = await availableCameras();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => AppCameraVideoPage(descriptions)));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 24, bottom: 24),
              width: MediaQuery.of(context).size.width,
              child: const Icon(
                Icons.videocam,
                size: 48,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
