import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class VideoCompressPage extends StatefulWidget {
  const VideoCompressPage({super.key});

  @override
  State<VideoCompressPage> createState() => _VideoCompressPageState();
}

class _VideoCompressPageState extends State<VideoCompressPage> {
  File? videoFile;
  Uint8List? thumbnail;
  int videoSize = 0;
  int? videoResize;
  String videoQuality = "Resize";

  @override
  void initState() {
    super.initState();
  }

  Future<void> resizing(VideoQuality quality) async {
    MediaInfo? info = await VideoCompress.compressVideo(
      videoFile!.path,
      quality: quality,
      includeAudio: true,
      deleteOrigin: true,
    );
    if (info != null) {
      setState(() {
        videoResize = info.filesize;
        videoQuality = quality.name;
      });
    }
  }

  Future<void> pickVideo() async {
    HapticFeedback.mediumImpact();
    final ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickVideo(source: ImageSource.gallery);
    if (file == null) return;
    Uint8List? getThumbnail = await VideoCompress.getByteThumbnail(file.path);
    int? getSize = await file.length();
    setState(() {
      videoFile = File(file.path);
      thumbnail = getThumbnail;
      videoSize = getSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Video Compress"),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              if (videoFile == null) {
                await pickVideo();
              } else {
                await resizing(VideoQuality.HighestQuality);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: 24, left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.black),
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: Center(
                child: Text(
                  videoFile != null ? "Resizing" : "Pick Video",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
          if (thumbnail != null && videoFile != null) ...[
            const SizedBox(height: 24),
            _info(content: "Original", size: videoSize),
            if (videoResize != null) ...[
              _info(
                  content: videoQuality,
                  size: videoResize!,
                  color: Colors.red,
                  fontSize: 18),
              const SizedBox(height: 24),
            ],
            Image.memory(thumbnail!),
          ],
        ],
      ),
    );
  }

  Padding _info({
    required String content,
    required int size,
    Color color = Colors.white,
    double fontSize = 14,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        "$content : ${(size / 1080)} kb",
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
