import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class AppCameraImagePage extends StatefulWidget {
  final List<CameraDescription> descriptions;

  const AppCameraImagePage(this.descriptions, {super.key});

  @override
  State<AppCameraImagePage> createState() => _AppCameraImagePageState();
}

class _AppCameraImagePageState extends State<AppCameraImagePage> {
  late CameraController controller;
  bool isCameraInitialized = false;
  bool isRecordingVideo = false;

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
    super.dispose();
  }

  Future<void> takePicture() async {
    XFile? rawImage = await controller.takePicture();
    await ImageGallerySaver.saveFile(rawImage.path);
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
            GestureDetector(
                onTap: () {
                  // controller.getMinExposureOffset();
                  // controller.getMaxZoomLevel();
                  // // controller.setZoomLevel(8.0);
                  // controller.setExposureOffset(0.0);
                },
                child: CameraPreview(controller)),
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
                    GestureDetector(
                      onTap: () async {
                        HapticFeedback.mediumImpact();
                        await takePicture();
                      },
                      child: const Icon(
                        Icons.camera,
                        size: 48,
                      ),
                    ),
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
          ] else ...[
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }
}
