import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/app/color_picker/color_picker_model.dart';

class ColorPickerProvider extends ChangeNotifier {
  List<ColorPickerModel> pickerColors = [];

  double currentPosition = 0;
  int duration = 0;
  late Color currentColor;
  int currentIndex = 0;
  List<ColorType> colorType = List.generate(
      ColorType.values.length, (index) => ColorType.values[index]);

  void _colorState(ColorType type) {
    pickerColors = List.generate(
        50,
        (index) => ColorPickerModel(
              index: (index - 49).abs(),
              color: Color.fromRGBO(
                  (type.rgb[0] + index > 255) ? 255 : type.rgb[0] + index,
                  (type.rgb[1] + index > 255) ? 255 : type.rgb[1] + index,
                  (type.rgb[2] + index > 255) ? 255 : type.rgb[2] + index,
                  1),
            ));
    pickerColors = pickerColors.reversed.toList();
    pickerColors.addAll([
      ...List.generate(
          50,
          (index) => ColorPickerModel(
                index: 50 + index,
                color: Color.fromRGBO(
                  (type.rgb[0] - index < 0) ? 0 : type.rgb[0] - index,
                  (type.rgb[1] - index < 0) ? 0 : type.rgb[1] - index,
                  (type.rgb[2] - index < 0) ? 0 : type.rgb[2] - index,
                  1,
                ),
              ))
    ]);
  }

  void colorChanged(ColorType type, int index) {
    _colorState(type);
    currentIndex = index;
    currentColor = pickerColors[49].color;
    currentPosition =
        ((MediaQueryData.fromWindow(window).size.width - 40) / 100) * 50;
    notifyListeners();
  }

  void pickerColorTap(ColorPickerModel data) {
    HapticFeedback.mediumImpact();
    duration = 200;
    double _width = (MediaQueryData.fromWindow(window).size.width - 40);
    currentColor = data.color;
    currentPosition = (_width / 100) * data.index;
    currentPosition = currentPosition < 20
        ? 10
        : currentPosition > (_width - 20)
            ? (_width - 20)
            : currentPosition;
    notifyListeners();
  }

  void dragUpdate(DragUpdateDetails? details) {
    HapticFeedback.lightImpact();
    double _dx = details!.delta.dx;
    double _itemWidth = (MediaQueryData.fromWindow(window).size.width) - 40;
    currentPosition = (currentPosition + _dx < 10) ||
            (currentPosition + _dx > _itemWidth - 20)
        ? currentPosition
        : currentPosition + _dx;
    currentColor = pickerColors[currentPosition ~/ (_itemWidth / 100)].color;
    notifyListeners();
  }

  void dragStart(DragStartDetails? details) {
    HapticFeedback.mediumImpact();
    duration = 0;
    notifyListeners();
  }
}
