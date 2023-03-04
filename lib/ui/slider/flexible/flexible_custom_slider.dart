import 'package:flutter/material.dart';

class FlexibleCustomSlider extends StatefulWidget {
  final int itemCount;
  final double? height;
  final double? width;
  final double viewportFraction;
  final List<Widget> items;
  final Function(int)? onPageChanged;
  const FlexibleCustomSlider({
    super.key,
    required this.itemCount,
    this.height,
    this.width,
    this.viewportFraction = 1.0,
    required this.items,
    this.onPageChanged,
  });

  @override
  State<FlexibleCustomSlider> createState() => _FlexibleCustomSliderState();
}

class _FlexibleCustomSliderState extends State<FlexibleCustomSlider> {
  ScrollController controller = ScrollController();
  late double _height;
  late double _width;

  double _currentPosition = 0.0;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double viewportFraction =
        widget.viewportFraction > 1.0 || widget.viewportFraction < 0.0
            ? 1.0
            : widget.viewportFraction;
    _height = widget.height ?? MediaQuery.of(context).size.width;
    _width =
        widget.width ?? MediaQuery.of(context).size.width * viewportFraction;
    return Column(
      children: [
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            double _dy = controller.position.pixels;
            controller.jumpTo(_dy - details.delta.dx);
            _currentPosition = _dy;
          },
          onHorizontalDragEnd: (detail) {
            double _dy = controller.position.pixels;
            if (_dy > _currentPosition) {
              double _currentMaxWidth = _width * (_currentIndex + 1);
              double _halfWidth = _width * _currentIndex;
              double _diffMaxWidth = (_currentMaxWidth - _halfWidth) / 3;
              double _point = _halfWidth + _diffMaxWidth;
              _currentIndex = _dy > _point ? _currentIndex + 1 : _currentIndex;
              _currentIndex = _currentIndex == widget.itemCount
                  ? _currentIndex - 1
                  : _currentIndex;
            } else {
              double _currentMaxWidth = _width * _currentIndex;
              double _halfWidth = _width / 3;
              double _point = _currentMaxWidth - _halfWidth;
              _currentIndex = _dy > _point ? _currentIndex : _currentIndex - 1;
              _currentIndex = _currentIndex < 0 ? 0 : _currentIndex;
            }
            controller.animateTo(_width * _currentIndex,
                duration: const Duration(milliseconds: 150),
                curve: Curves.decelerate);
            if (widget.onPageChanged != null) {
              widget.onPageChanged!(_currentIndex);
            }
          },
          child: SizedBox(
            width: widget.width ?? MediaQuery.of(context).size.width,
            height: _height,
            child: ListView.builder(
                controller: controller,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.itemCount,
                itemBuilder: (context, index) {
                  return Container(
                    height: _height,
                    width: index == widget.itemCount - 1
                        ? MediaQuery.of(context).size.width
                        : _width,
                    color: const Color.fromRGBO(115, 115, 115, 1),
                    child: widget.items[index],
                  );
                }),
          ),
        )
      ],
    );
  }
}
