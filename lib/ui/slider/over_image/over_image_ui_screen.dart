import 'package:flutter/material.dart';
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
            items: [
              ...List.generate(
                5,
                (index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom),
                      child: Text(
                        "${index + 1} View",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 80,
                          color: Colors.cyan.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
