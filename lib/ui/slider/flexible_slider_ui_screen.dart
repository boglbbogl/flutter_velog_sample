import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class FlexibleSliderUIScreen extends StatefulWidget {
  final int itemCount;
  const FlexibleSliderUIScreen({
    super.key,
    this.itemCount = 3,
  });

  @override
  State<FlexibleSliderUIScreen> createState() => _FlexibleSliderUIScreenState();
}

class _FlexibleSliderUIScreenState extends State<FlexibleSliderUIScreen> {
  late List<double> _positions = List.generate(widget.itemCount,
      (index) => index * MediaQuery.of(context).size.width * 0.8);
  int currentIndex = -0;

  @override
  void initState() {
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar(title: "Flexible Slider"),
      body: Column(
        children: [
          SizedBox(
            width: height,
            height: height,
            child: Stack(
                children: _children(
              height: height,
              width: width,
              itemCount: widget.itemCount,
            )),
          )
        ],
      ),
    );
  }

  List<Positioned> _children({
    required double height,
    required double width,
    required int itemCount,
  }) {
    return [
      ...List.generate(
          itemCount,
          (index) => Positioned(
                left: _positions[index],
                child: GestureDetector(
                  onPanEnd: (DragEndDetails details) {
                    setState(() {});
                  },
                  onPanUpdate: (DragUpdateDetails details) {
                    setState(() {
                      for (int i = 0; i < itemCount; i++) {
                        _positions[i] = _positions[i] + details.delta.dx;
                      }
                    });
                  },
                  child: Container(
                    height: height,
                    width: itemCount - 1 == index ? height : width,
                    color: Colors.accents[index],
                  ),
                ),
              ))
    ];
  }
}
