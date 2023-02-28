import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/ui/slider/overlap/overlap_custom_slider.dart';

class OverlapSliderUIScreen extends StatelessWidget {
  const OverlapSliderUIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Overlap Slider"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("data"),
          ),
          OverlapCustomSlider(),
        ],
      ),
    );
  }
}
