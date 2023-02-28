import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/ui/slider/flexible_custom_slider.dart';

class FlexibleSliderUIScreen extends StatelessWidget {
  const FlexibleSliderUIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> _assets = [
      "assets/images/koenigsegg_01.jpeg",
      "assets/images/koenigsegg_02.jpeg",
      "assets/images/koenigsegg_03.jpeg",
    ];
    return Scaffold(
      appBar: appBar(title: "Flexible Slider"),
      body: ListView(
        children: [
          _textForm(0.9, 3),
          FlexibleCustomSlider(
            itemCount: 3,
            viewportFraction: 0.9,
            onPageChanged: (i) {},
            height: 200,
            items: [
              ...List.generate(
                3,
                (index) => Image.asset(
                  _assets[index],
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
          _textForm(0.9, 3),
          FlexibleCustomSlider(
            itemCount: 3,
            viewportFraction: 0.8,
            onPageChanged: (i) {},
            height: 180,
            items: [
              ...List.generate(
                3,
                (index) => Image.asset(
                  _assets[index],
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _textForm(double fraction, int count) {
    return Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 8),
        child: RichText(
            text: TextSpan(
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromRGBO(215, 215, 215, 1)),
                text: "Viewport Fraction  :  ",
                children: [
              TextSpan(
                  text: "$fraction",
                  style: const TextStyle(
                    color: Colors.yellow,
                  )),
              const TextSpan(
                text: "    |    ",
              ),
              const TextSpan(text: "Count  :  "),
              TextSpan(
                  text: "$count",
                  style: const TextStyle(
                    color: Colors.orange,
                  )),
            ])));
  }
}
