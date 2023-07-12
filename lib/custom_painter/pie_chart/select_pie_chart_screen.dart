import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class SelectPieChartScreen extends StatefulWidget {
  const SelectPieChartScreen({super.key});

  @override
  State<SelectPieChartScreen> createState() => _SelectPieChartScreenState();
}

class _SelectPieChartScreenState extends State<SelectPieChartScreen> {
  final List<GlobalKey> globalKey = List.generate(2, (_) => GlobalKey());
  final List<bool> isSelected = List.generate(2, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Select Pie Chart"),
      body: Column(
        children: [
          SizedBox(
            child: Listener(
              onPointerUp: (details) {
                RenderBox box = globalKey[0].currentContext!.findRenderObject()
                    as RenderBox;
                BoxHitTestResult result = BoxHitTestResult();
                Offset offset = box.localToGlobal(details.position);
                if (box.hitTest(result, position: offset)) {
                  setState(() {
                    isSelected[0] = !isSelected[0];
                  });
                }
              },
              child: Stack(
                children: [
                  CustomPaint(
                    key: globalKey[0],
                    painter: _PieChart(isSelected[0]),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                    ),
                  ),
                  CustomPaint(
                    key: globalKey[1],
                    size: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.width),
                    painter: _PieChart2(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PieChart2 extends CustomPainter {
  // final List<PieModel> data;

  _PieChart2();
  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()..color = Colors.white;

    // Offset offset = Offset(size.width / 2, size.width / 2);
    double radius = (size.width / 2) * 0.8;
    // canvas.drawCircle(offset, radius, circlePaint);

    double _startAngle = 2 * math.pi * (30 / 100);
    double _nextAngle = 2 * math.pi * (40 / 100);
    circlePaint.color = Colors.red;

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.width / 2), radius: radius),
        -math.pi / 2 + _startAngle,
        _nextAngle,
        true,
        circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PieChart extends CustomPainter {
  final bool isSelected;
  // final List<PieModel> data;

  _PieChart(this.isSelected);
  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()..color = Colors.white;

    // Offset offset = Offset(size.width / 2, size.width / 2);
    double radius = (size.width / 2) * 0.8;
    // canvas.drawCircle(offset, radius, circlePaint);

    // double _startAngle = 2 * math.pi * (30 / 100);
    double _nextAngle = 2 * math.pi * (30 / 100);
    circlePaint.color = Colors.amber;
    int _position = isSelected ? 3 : 2;

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / _position, size.width / 2),
            radius: radius),
        -math.pi / 2,
        _nextAngle,
        true,
        circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      isSelected != isSelected;
}
