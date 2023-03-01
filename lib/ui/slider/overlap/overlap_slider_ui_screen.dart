import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:flutter_velog_sample/ui/slider/overlap/overlap_custom_slider.dart';

class OverlapSliderUIScreen extends StatelessWidget {
  const OverlapSliderUIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> _porsches = List.generate(
        6, (index) => "assets/images/porsche/porsche_911_0${index + 1}.png");
    List<String> _marvel = [
      "assets/images/marvel/marvel_01.jpeg",
      "assets/images/marvel/marvel_02.jpeg",
      "assets/images/marvel/marvel_03.jpg",
      "assets/images/marvel/marvel_04.jpeg",
      "assets/images/marvel/marvel_05.jpeg",
      "assets/images/marvel/marvel_06.png",
    ];
    return Scaffold(
      appBar: appBar(title: "Overlap Slider"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleForm("Porsche 911"),
          OverlapCustomSlider(items: _porsches),
          _titleForm("Marvel"),
          OverlapCustomSlider(
            items: _marvel,
            height: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }

  Padding _titleForm(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 32, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      ),
    );
  }
}
