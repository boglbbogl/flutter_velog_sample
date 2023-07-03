import 'package:flutter/material.dart';

class OverImageCustomSlider extends StatefulWidget {
  final int itemCount;
  final List<Widget> items;
  const OverImageCustomSlider({
    super.key,
    required this.itemCount,
    required this.items,
  });

  @override
  State<OverImageCustomSlider> createState() => _OverImageCustomSliderState();
}

class _OverImageCustomSliderState extends State<OverImageCustomSlider> {
  double _position = 0.0;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          kToolbarHeight,
      child: Stack(
        children: [
          Positioned(
            left: _position,
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                double _halfWidth = _width * _currentIndex;
                double _nextPoint = _currentIndex == 0
                    ? (_width / 3)
                    : _halfWidth + (_width / 3);
                double _beforePoint = (_width * _currentIndex) - (_width / 3);
                if (-_position > _nextPoint) {
                  setState(() {
                    _position = -((_width * _currentIndex) + _width);
                    _currentIndex = _currentIndex + 1;
                    if (_currentIndex > widget.itemCount - 1) {
                      _position = -(_width * (_currentIndex - 1));
                      _currentIndex = widget.itemCount - 1;
                    }
                  });
                } else if (-_position < _beforePoint) {
                  setState(() {
                    _position = -(_width * _currentIndex) + _width;
                    _currentIndex = _currentIndex - 1;
                    if (_currentIndex < 0) {
                      _position = 0.0;
                      _currentIndex = 0;
                    }
                  });
                } else {
                  setState(() {
                    _position = -(_width * _currentIndex);
                  });
                }
              },
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _position = _position + details.delta.dx;
                });
              },
              child: Container(
                width: _width * widget.itemCount,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black, BlendMode.saturation),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        image: AssetImage(
                            "assets/images/city/panorama_city.jpeg"))),
                child: Row(
                  children: [
                    ...List.generate(
                        widget.itemCount,
                        (index) => SizedBox(
                              width: _width,
                              child: widget.items[index],
                            ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
