import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/custom_painter/chart/painter_pie_chart_screen.dart';

class PainterRadialChartScreen extends StatefulWidget {
  const PainterRadialChartScreen({super.key});

  @override
  State<PainterRadialChartScreen> createState() =>
      _PainterRadialChartScreenState();
}

class _PainterRadialChartScreenState extends State<PainterRadialChartScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  List<PieModel> data = [
    PieModel(count: 30, color: Colors.amber),
    PieModel(count: 20, color: Colors.red),
    PieModel(count: 10, color: Colors.blue),
    PieModel(count: 20, color: Colors.green),
    PieModel(count: 20, color: Colors.purple),
  ];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
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
      appBar: appBar(title: "Radial Chart"),
      body: Column(
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              if (animationController.value < 0.1) {
                return const SizedBox();
              } else {
                return SizedBox(
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.width),
                    painter: _RadialChart(data, animationController.value),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _RadialChart extends CustomPainter {
  final List<PieModel> data;
  final double value;
  _RadialChart(this.data, this.value);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color.fromRGBO(61, 61, 61, 1);

    Offset offset = Offset(size.width / 2, size.width / 2);
    double radius = (size.width / 2) * 0.8;

    canvas.drawCircle(offset, radius, paint);
    paint.strokeWidth = 10;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    for (int i = 0; i < data.length; i++) {
      double _count = data[i].count.toDouble();
      _count = (_count * value + _count) - data[i].count;

      double position = double.parse("0.${8 - i}");
      radius = ((size.width / 2) * position) - 5;
      double _nextAngle = 2 * math.pi * (_count / 100);
      paint.color = data[i].color;
      canvas.drawArc(
        Rect.fromCircle(center: offset, radius: radius),
        -math.pi / 2,
        _nextAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
