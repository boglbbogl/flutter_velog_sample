import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController controller;
  double? aspectRatio;
  double progress = 0;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("assets/videos/test_video_2.mp4")
      ..initialize();
    controller.setPlaybackSpeed(1);
    played();

    controller.addListener(() async {
      int max = controller.value.duration.inSeconds;
      setState(() {
        aspectRatio = controller.value.aspectRatio;
        position = controller.value.position;
        progress = (position.inSeconds / max * 100).isNaN
            ? 0
            : position.inSeconds / max * 100;
      });
    });
  }

  void played() => controller.play();

  void stoped() => controller.pause();

  void seekTo(int value) {
    int add = position.inSeconds + value;

    controller.seekTo(Duration(seconds: add < 0 ? 0 : add));
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
      body: Stack(
        children: [
          if (aspectRatio != null) ...[
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom:
                        MediaQuery.of(context).padding.top + kToolbarHeight),
                child: AspectRatio(
                    aspectRatio: aspectRatio!, child: VideoPlayer(controller)),
              ),
            ),
            Positioned(
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        seekTo(-10);
                      },
                      child: const SizedBox(
                        width: 30,
                        child: Icon(
                          Icons.replay_10_rounded,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        if (controller.value.isPlaying) {
                          stoped();
                        } else {
                          played();
                        }
                      },
                      child: SizedBox(
                        width: 30,
                        child: Icon(
                          controller.value.isPlaying
                              ? Icons.stop
                              : Icons.play_arrow_rounded,
                          size: 32,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        seekTo(10);
                      },
                      child: const SizedBox(
                        width: 30,
                        child: Icon(
                          Icons.forward_10_rounded,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                        width: 30,
                        child: Text(
                          controller.value.position.toString().substring(2, 7),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        )),
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 6,
                          width: MediaQuery.of(context).size.width - 206,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color.fromRGBO(135, 135, 135, 1),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 6,
                          width: (MediaQuery.of(context).size.width - 206) *
                              (progress / 100),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color.fromRGBO(215, 215, 215, 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        width: 30,
                        child: Text(
                          controller.value.duration.toString().substring(2, 7),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        )),
                  ],
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
