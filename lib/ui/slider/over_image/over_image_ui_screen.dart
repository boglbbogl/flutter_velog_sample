import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/ui/slider/over_image/over_image_custom_slider.dart';

class OverImageUIScreen extends StatelessWidget {
  const OverImageUIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Over Image Slider"),
      body: Column(
        children: [
          OverImageCustomSlider(
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}
