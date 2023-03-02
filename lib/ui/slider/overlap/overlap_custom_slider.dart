import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_size.dart';

class OverlapCustomSlider extends StatefulWidget {
  final List<String> items;
  final double? height;
  const OverlapCustomSlider({
    super.key,
    required this.items,
    this.height,
  });

  @override
  State<OverlapCustomSlider> createState() => _OverlapCustomSliderState();
}

class _OverlapCustomSliderState extends State<OverlapCustomSlider> {
  final List<String> _stackData = [];
  List<String> _nextData = [];
  late double _height;

  @override
  void initState() {
    List<String> _settingData = widget.items;
    _stackData.add(_settingData.first);
    _nextData
      ..addAll(_settingData)
      ..remove(_nextData.first);
    _nextData = _nextData.reversed.toList();
    super.initState();
  }

  late double _position = size.width;
  @override
  Widget build(BuildContext context) {
    _height = widget.height ?? MediaQuery.of(context).size.width / 2;
    return SizedBox(
      height: _height,
      child: Stack(
        children: [
          ...List.generate(
              _stackData.length,
              (index) => Positioned(
                    left: 0,
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) {
                        setState(() {
                          if (size.width / 2 < _position) {
                            _position = size.width;
                          } else {
                            _position = 0.0;
                            _stackData.add(_nextData.last);
                            _nextData.remove(_nextData.last);
                            if (_nextData.isEmpty) {
                              _nextData.addAll(_stackData);
                              _stackData
                                ..clear()
                                ..add(_nextData.last);
                              _nextData.remove(_nextData.last);
                              _nextData = _nextData.reversed.toList();
                            }

                            _position = size.width;
                          }
                        });
                      },
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          if (_nextData.isNotEmpty) {
                            _position = _position + details.delta.dx;
                          }
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: _height,
                        color: Colors.white,
                        child: Image.asset(
                          _stackData[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )),
          ...List.generate(
              _nextData.length,
              (index) => Positioned(
                    left: _position,
                    child: GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: _height,
                        color: Colors.white,
                        child: Image.asset(
                          _nextData[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
