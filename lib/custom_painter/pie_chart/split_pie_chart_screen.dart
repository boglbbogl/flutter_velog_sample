import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class SplitPieChartScreen extends StatefulWidget {
  const SplitPieChartScreen({super.key});

  @override
  State<SplitPieChartScreen> createState() => _SplitPieChartScreenState();
}

class _SplitPieChartScreenState extends State<SplitPieChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Split Pie Chart"),
      body: Column(
        children: [
          Container(
            color: Colors.red.withOpacity(0.3),
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.width),
              painter: _PieChart(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PieChart extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black;

    Offset offset = Offset(size.width / 2, size.width / 2);
    double radius = (size.width / 2) * 0.8;

    canvas.drawCircle(offset, radius, paint);

    paint.color = Colors.amber;
    canvas.drawArc(Rect.fromCircle(center: offset, radius: radius), 2 * pi, 2,
        false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
