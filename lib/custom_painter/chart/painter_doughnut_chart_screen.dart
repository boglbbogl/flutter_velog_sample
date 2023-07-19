import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/custom_painter/chart/painter_pie_chart_screen.dart';

class PainterDoughnutChartScreen extends StatefulWidget {
  const PainterDoughnutChartScreen({super.key});

  @override
  State<PainterDoughnutChartScreen> createState() =>
      _PainterDoughnutChartScreenState();
}

class _PainterDoughnutChartScreenState extends State<PainterDoughnutChartScreen>
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
      appBar: appBar(title: "Doughnut Chart"),
      body: Column(
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              if (animationController.value < 0.1) {
                return const SizedBox();
              }
              return SizedBox(
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.width),
                  painter: _DoughnutChart(data, animationController.value),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DoughnutChart extends CustomPainter {
  final List<PieModel> data;
  final double value;
  _DoughnutChart(this.data, this.value);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color.fromRGBO(61, 61, 61, 1);

    Offset offset = Offset(size.width / 2, size.width / 2);
    double radius = (size.width / 2) * 0.8;

    canvas.drawCircle(offset, radius, paint);
    paint.strokeWidth = 50;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    double _startPoint = 0.0;
    for (int i = 0; i < data.length; i++) {
      double _count = data[i].count.toDouble();

      _count = (_count * value + _count) - data[i].count;
      radius = ((size.width / 2) * 0.8) - 25;
      double _nextAngle = 2 * math.pi * (_count / 100);
      paint.color = data[i].color;
      canvas.drawArc(
        Rect.fromCircle(center: offset, radius: radius),
        -math.pi / 2 + _startPoint,
        _nextAngle,
        false,
        paint,
      );
      _startPoint = _startPoint + _nextAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
