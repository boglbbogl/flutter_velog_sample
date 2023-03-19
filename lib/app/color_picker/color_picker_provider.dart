import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/app/color_picker/color_picker_model.dart';
import 'package:flutter_velog_sample/app/color_picker/color_picker_services.dart';

class ColorPickerProvider extends ChangeNotifier {
  List<ColorPickerModel> pickerColors = [];
  List<Color> colorList = [
    const Color.fromRGBO(255, 0, 0, 1),
    const Color.fromRGBO(233, 30, 99, 1),
    const Color.fromRGBO(255, 87, 34, 1),
    const Color.fromRGBO(255, 152, 0, 1),
    const Color.fromRGBO(255, 193, 7, 1),
    const Color.fromRGBO(255, 235, 59, 1),
    const Color.fromRGBO(139, 195, 74, 1),
    const Color.fromRGBO(76, 175, 80, 1),
    const Color.fromRGBO(0, 188, 212, 1),
    const Color.fromRGBO(3, 169, 244, 1),
    const Color.fromRGBO(33, 150, 243, 1),
  ];
  double currentPosition = 0;
  int duration = 0;
  late Color currentColor;

  void _colorState(int index) {
    switch (index) {
      case 0:
        pickerColors = ColorPickerServices.instance.red();
        break;
      case 1:
        pickerColors = ColorPickerServices.instance.pink();
        break;
      case 2:
        pickerColors = ColorPickerServices.instance.deepOrange();
        break;
      case 3:
        pickerColors = ColorPickerServices.instance.orange();
        break;
      case 4:
        pickerColors = ColorPickerServices.instance.amber();
        break;
      case 5:
        pickerColors = ColorPickerServices.instance.yellow();
        break;
      case 6:
        pickerColors = ColorPickerServices.instance.lightGreen();
        break;
      case 7:
        pickerColors = ColorPickerServices.instance.green();
        break;
      case 8:
        pickerColors = ColorPickerServices.instance.cyan();
        break;
      case 9:
        pickerColors = ColorPickerServices.instance.lightBlue();
        break;
      case 10:
        pickerColors = ColorPickerServices.instance.blue();
        break;
      default:
        pickerColors = ColorPickerServices.instance.red();
        break;
    }
  }

  void colorChanged(int index) {
    _colorState(index);
    currentColor = pickerColors[49].color;
    currentPosition =
        ((MediaQueryData.fromWindow(window).size.width - 40) / 100) * 50;
    notifyListeners();
  }

  void pickerColorTap(ColorPickerModel data) {
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
    duration = 0;
    notifyListeners();
  }
}
