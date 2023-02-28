import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/main.dart';

class OverlapCustomSlider extends StatefulWidget {
  const OverlapCustomSlider({super.key});

  @override
  State<OverlapCustomSlider> createState() => _OverlapCustomSliderState();
}

class _OverlapCustomSliderState extends State<OverlapCustomSlider> {
  final List<String> _assets = List.generate(
      6, (index) => "assets/images/porsche/porsche_911_0${index + 1}.png");
  List<double> _position = List.generate(6, (i) => i == 5 ? 0.0 : 300);
  @override
  Widget build(BuildContext context) {
    // _width = List.generate(6, (index) => MediaQuery.of(context).size.width);
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          ...List.generate(
              6,
              (index) => Positioned(
                    left: _position[index],
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _position[index - 1] =
                              _position[index - 1] + details.delta.dx;
                          logger.e(index);
                        });
                      },
                      child: Container(
                        color: Colors.accents[index],
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          _assets[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )),
          // Positioned(
          //   child: Container(
          //     color: Colors.red,
          //     width: 400,
          //     height: 200,
          //     child: Stack(
          //       children: [
          //         Image.asset(
          //           "assets/images/porsche/porsche_911_01.png",
          //           // width: 400,
          //           height: 500,
          //           fit: BoxFit.fill,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Positioned(
          //   left: 200,
          //   child: Container(
          //     color: Colors.amber,
          //     width: 300,
          //     height: 200,
          //     child: Stack(
          //       children: [
          //         Image.asset(
          //           "assets/images/porsche/porsche_911_02.png",
          //           // width: 400,
          //           height: 500,
          //           fit: BoxFit.fill,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
