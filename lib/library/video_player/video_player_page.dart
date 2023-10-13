import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController controller;
  // File? videoFile;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("assets/videos/test_video_2.mp4")
      ..initialize();
    // controller = VideoPlayerController.networkUrl(Uri.parse(
    //     "https://firebasestorage.googleapis.com/v0/b/flutter-velog-sample.appspot.com/o/KEYCUTstock_preview_UK14030.mp4?alt=media&token=93f38e19-41f4-4aeb-b6bc-2df9ed9d135a&_gl=1*1o74ov2*_ga*MTMwNTY4NTMwLjE2ODAyNDU1OTc.*_ga_CW55HF8NVT*MTY5NzE4MTg5Ni4yNjkuMS4xNjk3MTgyNDQyLjU3LjAuMA"))
    // ..initialize();
    controller.setPlaybackSpeed(1);

    controller.play();

    controller.setVolume(0.4);

    controller.addListener(() async {
      // logger.e(controller.value.aspectRatio);
      // logger.e(controller.value.duration);
      controller.seekTo(Duration(seconds: 17));
      logger.e(controller.value.position);
      logger.e(controller.value.volume);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Video Player"),
      body: Column(
        children: [
          Stack(
            children: [
              AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller)),
            ],
          ),
        ],
      ),
    );
  }
}
