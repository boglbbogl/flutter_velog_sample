import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class PainterAppleWatchScreen extends StatefulWidget {
  const PainterAppleWatchScreen({super.key});

  @override
  State<PainterAppleWatchScreen> createState() =>
      _PainterAppleWatchScreenState();
}

class _PainterAppleWatchScreenState extends State<PainterAppleWatchScreen> {
  late DateTime now;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Apple Watch"),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: CustomPaint(
              painter: _AppleWatch(now),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppleWatch extends CustomPainter {
  final TextPainter tp;
  final Color primaryColor;
  final DateTime now;
  _AppleWatch(
    this.now,
  )   : tp = TextPainter(
          textDirection: TextDirection.ltr,
        ),
        primaryColor = const Color(0xFFE57242);

  @override
  void paint(Canvas canvas, Size size) {
    double _xCenter = size.width / 2;
    double _yCenter = size.height / 2;
    double angle = (2 * pi) / 12;
    canvas.save();
    canvas.translate(_xCenter, _yCenter);

    renderText(canvas, size, _xCenter, _yCenter, angle);
    renderHands(canvas, size, _xCenter, _yCenter);
    canvas.restore();
  }

  void renderHands(Canvas canvas, Size size, double xCenter, double yCenter) {
    canvas.save();

    Paint innerPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    Paint outerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    Paint secPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.square;

    Paint rootPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.square;

    Paint rootWhiteCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Paint rootPrimaryCirclePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    Paint rootBlackCirclePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    double rootOffset = 14.0;

    double hourAngle =
        (now.hour % 12) * (2 * pi / 12) + (now.minute) * (2 * pi / (12 * 60));
    double minuteAngle = now.minute * (2 * pi / 60);
    double secondAngle = now.second * (2 * pi / 60);

    canvas.save();

    canvas.rotate(hourAngle);
    canvas.drawLine(Offset.zero, Offset(0.0, -rootOffset), rootPaint);
    canvas.drawLine(
        Offset(0.0, -rootOffset), Offset(0.0, -xCenter * 0.7), outerPaint);
    canvas.drawLine(
        Offset(0.0, -rootOffset), Offset(0.0, -xCenter * 0.7), innerPaint);
    canvas.restore();

    canvas.save();
    canvas.rotate(minuteAngle);
    canvas.drawLine(Offset.zero, Offset(0.0, -rootOffset), rootPaint);
    canvas.drawLine(
        Offset(0.0, -rootOffset), Offset(0.0, -xCenter * 0.9), outerPaint);
    canvas.drawLine(
        Offset(0.0, -rootOffset), Offset(0.0, -xCenter * 0.9), innerPaint);
    canvas.restore();

    canvas.save();
    canvas.rotate(secondAngle);
    canvas.drawLine(
        const Offset(0.0, -10.0), Offset(0.0, -xCenter * 0.9), secPaint);
    canvas.drawCircle(Offset.zero, 6.0, rootWhiteCirclePaint);
    canvas.drawCircle(Offset.zero, 4.0, rootPrimaryCirclePaint);
    canvas.drawCircle(Offset.zero, 2.0, rootBlackCirclePaint);
    canvas.restore();

    canvas.restore();
  }

  void renderText(
      Canvas canvas, Size size, double xCenter, double yCenter, double angle) {
    canvas.save();

    double _vertLength = yCenter / cos(angle);
    double _horiLenght = xCenter / sin(angle * 2);
    List<double> lenghtList = [
      yCenter,
      _vertLength,
      _horiLenght,
      xCenter,
      _horiLenght,
      _vertLength,
      yCenter,
    ];

    for (int i = 0; i < 12; i++) {
      canvas.save();
      canvas.translate(0.0, -lenghtList[i % 6]);
      String display = i == 0 ? "12" : i.toString();

      tp.text = TextSpan(
          text: display,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ));

      canvas.rotate(-angle * i);
      tp.layout();
      tp.paint(canvas, Offset(-(tp.width / 2), -(tp.height / 2)));
      canvas.restore();

      canvas.rotate(angle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
