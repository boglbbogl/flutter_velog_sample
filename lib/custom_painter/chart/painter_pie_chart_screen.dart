import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class PieModel {
  final int count;
  final Color color;

  PieModel({
    required this.count,
    required this.color,
  });
}

class PainterPieChatScreen extends StatefulWidget {
  const PainterPieChatScreen({super.key});

  @override
  State<PainterPieChatScreen> createState() => _PainterPieChatScreenState();
}

class _PainterPieChatScreenState extends State<PainterPieChatScreen> {
  @override
  Widget build(BuildContext context) {
    List<PieModel> model = [
      PieModel(count: 30, color: Colors.red.withOpacity(1)),
      PieModel(count: 5, color: Colors.blue.withOpacity(1)),
      PieModel(count: 3, color: Colors.grey.withOpacity(1)),
      PieModel(count: 10, color: Colors.amber.withOpacity(1)),
      PieModel(count: 2, color: Colors.green.withOpacity(1)),
      PieModel(count: 30, color: Colors.cyan.withOpacity(1)),
      PieModel(count: 20, color: Colors.purple.withOpacity(1)),
    ];
    return Scaffold(
      appBar: appBar(title: "Pie Chart"),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.width),
              painter: _PieChart(model),
            ),
          ),
        ],
      ),
    );
  }
}

class _PieChart extends CustomPainter {
  final List<PieModel> data;

  _PieChart(this.data);
  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()..color = Colors.white;

    Offset offset = Offset(size.width / 2, size.width / 2);
    double radius = (size.width / 2) * 0.8;
    canvas.drawCircle(offset, radius, circlePaint);

    double _startPoint = 0.0;
    for (int i = 0; i < data.length; i++) {
      double _startAngle = 2 * math.pi * (data[i].count / 100);
      double _nextAngle = 2 * math.pi * (data[i].count / 100);
      circlePaint.color = data[i].color;

      canvas.drawArc(
          Rect.fromCircle(
              center: Offset(size.width / 2, size.width / 2), radius: radius),
          -math.pi / 2 + _startPoint,
          _nextAngle,
          true,
          circlePaint);
      _startPoint = _startPoint + _startAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
