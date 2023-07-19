import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'dart:math' as math;

import 'package:flutter_velog_sample/custom_painter/chart/painter_pie_chart_screen.dart';

class PainterAnimationPieChartScreen extends StatefulWidget {
  const PainterAnimationPieChartScreen({super.key});

  @override
  State<PainterAnimationPieChartScreen> createState() =>
      _PainterAnimationPieChartScreenState();
}

class _PainterAnimationPieChartScreenState
    extends State<PainterAnimationPieChartScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  List<PieModel> model = [
    PieModel(count: 12, color: Colors.red.withOpacity(1)),
    PieModel(count: 18, color: Colors.blue.withOpacity(1)),
    PieModel(count: 23, color: Colors.grey.withOpacity(1)),
    PieModel(count: 31, color: Colors.amber.withOpacity(1)),
    PieModel(count: 6, color: Colors.green.withOpacity(1)),
    PieModel(count: 4, color: Colors.cyan.withOpacity(1)),
    PieModel(count: 6, color: Colors.purple.withOpacity(1)),
  ];
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Animation Pie Chart"),
      body: Column(
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              if (animationController.value < 0.1) {
                return const SizedBox();
              }
              return CustomPaint(
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.width),
                painter: _PieChart(model, animationController.value),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PieChart extends CustomPainter {
  final List<PieModel> data;
  final double value;

  _PieChart(this.data, this.value);
  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()..color = Colors.white;
    double radius = (size.width / 2) * 0.8;
    double _startPoint = 0.0;
    for (int i = 0; i < data.length; i++) {
      double _count = data[i].count.toDouble();
      _count = (_count * value + _count) - data[i].count;

      double _startAngle = 2 * math.pi * (_count / 100);
      double _nextAngle = 2 * math.pi * (_count / 100);
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
