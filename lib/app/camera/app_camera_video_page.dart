import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io';

import 'package:video_compress/video_compress.dart';

class AppCameraVideoPage extends StatefulWidget {
  final List<CameraDescription> descriptions;

  const AppCameraVideoPage(this.descriptions, {super.key});

  @override
  State<AppCameraVideoPage> createState() => _AppCameraVideoPageState();
}

class _AppCameraVideoPageState extends State<AppCameraVideoPage> {
  late CameraController controller;
  bool isCameraInitialized = false;
  bool isRecordingVideo = false;
  Timer? timer;

  int? duration;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.descriptions[0], ResolutionPreset.low)
      ..initialize();
    controller.addListener(() {
      setState(() {
        isCameraInitialized = controller.value.isInitialized;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  Future<void> startRecording() async {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        duration = timer.tick;
        isRecordingVideo = true;
      });
    });
    await controller.startVideoRecording();
  }

  Future<void> toFirestoreWithResizing(XFile file) async {
    MediaInfo? info = await VideoCompress.compressVideo(
      file.path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: true,
    );
    if (info != null) {
      File _file = File(info.path!);
      String ref = "videos/medium_${DateTime.now().millisecondsSinceEpoch}";
      await FirebaseStorage.instance.ref(ref).putFile(_file);
      final String _urlString =
          await FirebaseStorage.instance.ref(ref).getDownloadURL();
      logger.e(_urlString);
    } else {
      logger.e("error");
    }
  }

  Future<void> toFirestoreWithOriginal(XFile file) async {
    File _file = File(file.path);
    String ref = "videos/${DateTime.now().millisecondsSinceEpoch}";
    await FirebaseStorage.instance.ref(ref).putFile(_file);
    final String _urlString =
        await FirebaseStorage.instance.ref(ref).getDownloadURL();
    logger.e(_urlString);
  }

  Future<void> stopRecording() async {
    XFile? file = await controller.stopVideoRecording();
    await ImageGallerySaver.saveFile(file.path);
    setState(() {
      isRecordingVideo = false;
    });
    timer?.cancel();
    // await toFirestoreWithOriginal(file);
    await toFirestoreWithResizing(file);
  }

  void cameraChanged() async {
    if (controller.description.lensDirection == CameraLensDirection.back) {
      controller.setDescription(widget.descriptions[1]);
    } else {
      controller.setDescription(widget.descriptions[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (isCameraInitialized) ...[
            SizedBox(
              child: CameraPreview(controller),
            ),
            Positioned(
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        controller.resolutionPreset.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    if (isRecordingVideo) ...[
                      GestureDetector(
                        onTap: () async {
                          HapticFeedback.mediumImpact();
                          await stopRecording();
                        },
                        child: const Icon(
                          Icons.stop,
                          size: 48,
                        ),
                      ),
                    ] else ...[
                      GestureDetector(
                        onTap: () async {
                          HapticFeedback.mediumImpact();
                          startRecording();
                        },
                        child: const Icon(
                          Icons.camera,
                          size: 48,
                        ),
                      ),
                    ],
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        cameraChanged();
                      },
                      child: const SizedBox(
                        width: 40,
                        child: Icon(
                          Icons.change_circle_outlined,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (duration != null) ...[
              Positioned(
                bottom: 100,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      duration!.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 60),
                    ),
                  ),
                ),
              ),
            ],
          ] else ...[
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }
}
