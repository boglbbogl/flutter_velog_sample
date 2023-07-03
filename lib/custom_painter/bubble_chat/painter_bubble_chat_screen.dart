import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class PainterBubbleChatScreen extends StatelessWidget {
  const PainterBubbleChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Bubble Chat"),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            color: Colors.amber,
            child: CustomPaint(
              painter: _BubbleChat(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BubbleChat extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
