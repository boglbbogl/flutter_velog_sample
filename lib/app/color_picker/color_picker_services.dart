import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/app/color_picker/color_picker_model.dart';

class ColorPickerServices {
  static final ColorPickerServices instance = ColorPickerServices._internal();
  factory ColorPickerServices() => instance;
  ColorPickerServices._internal();
  List<ColorPickerModel> blue() {
    Color.fromRGBO(33, 150, 243, 1);
    List<ColorPickerModel> _colors;
    _colors = List.generate(
        50,
        (index) => ColorPickerModel(
              index: (index - 49).abs(),
              color: Color.fromRGBO(33, 150, 243 - index, 1),
            ));
    _colors = _colors.reversed.toList();
    _colors.addAll([
      ...List.generate(
          50,
          (index) => ColorPickerModel(
                index: 50 + index,
                color: Color.fromRGBO(33, 150 - (index * 2), 243, 1),
              ))
    ]);
    return _colors;
  }

  List<ColorPickerModel> lightBlue() {
    List<ColorPickerModel> _colors;
    _colors = List.generate(
        50,
        (index) => ColorPickerModel(
              index: (index - 49).abs(),
              color: Color.fromRGBO(3 + (index * 2), 169, 244 - index, 1),
            ));
    _colors = _colors.reversed.toList();
    _colors.addAll([
      ...List.generate(
          50,
          (index) => ColorPickerModel(
                index: 50 + index,
                color:
                    Color.fromRGBO(3, 169 - (index * 2), 244 - (index * 2), 1),
              ))
    ]);
    return _colors;
  }

  List<ColorPickerModel> cyan() {
    List<ColorPickerModel> _colors;
    _colors = List.generate(
        50,
        (index) => ColorPickerModel(
              index: (index - 49).abs(),
              color: Color.fromRGBO(0 + (index * 2), 188, 212, 1),
            ));
    _colors = _colors.reversed.toList();
    _colors.addAll([
      ...List.generate(
          50,
          (index) => ColorPickerModel(
                index: 50 + index,
                color:
                    Color.fromRGBO(0, 188 - (index * 2), 212 - (index * 2), 1),
              ))
    ]);
    return _colors;
  }

  List<ColorPickerModel> green() {
    List<ColorPickerModel> _colors;
    _colors = List.generate(
        50,
        (index) => ColorPickerModel(
              index: (index - 49).abs(),
              color: Color.fromRGBO(76 + index, 175 + index, 80, 1),
            ));
    _colors = _colors.reversed.toList();
    _colors.addAll([
      ...List.generate(
          50,
          (index) => ColorPickerModel(
                index: 50 + index,
                color: Color.fromRGBO(76, 175 - index, 80, 1),
              ))
    ]);
    return _colors;
  }

  List<ColorPickerModel> lightGreen() {
    List<ColorPickerModel> _colors;
    _colors = List.generate(
        50,
        (index) => ColorPickerModel(
              index: (index - 49).abs(),
              color: Color.fromRGBO(139 + index, 195 + index, 74 + index, 1),
            ));
    _colors = _colors.reversed.toList();
    _colors.addAll([
      ...List.generate(
          50,
          (index) => ColorPickerModel(
                index: 50 + index,
                color: Color.fromRGBO(139 - index, 195 - index, 74 - index, 1),
              ))
    ]);
    return _colors;
  }

  List<ColorPickerModel> yellow() {
    List<ColorPickerModel> _colors;
    _colors = List.generate(
        50,
        (index) => ColorPickerModel(
              index: (index - 49).abs(),
              color: Color.fromRGBO(255 - index, 235 - index, 59 + index, 1),
            ));
    _colors = _colors.reversed.toList();
    _colors.addAll([
      ...List.generate(
          50,
          (index) => ColorPickerModel(
                index: 50 + index,
                color: Color.fromRGBO(255 - index, 235 - (index * 2), 59, 1),
              ))
    ]);
    return _colors;
  }

  List<ColorPickerModel> amber() {
    List<ColorPickerModel> _colors;
    _colors = List.generate(
        50,
        (index) => ColorPickerModel(
              index: (index - 49).abs(),
              color: Color.fromRGBO(255, 193, 7 + (index * 2), 1),
            ));
    _colors = _colors.reversed.toList();
    _colors.addAll([
      ...List.generate(
          50,
          (index) => ColorPickerModel(
                index: 50 + index,
                color: Color.fromRGBO(255, 193 - index, 7, 1),
              ))
    ]);
    return _colors;
  }

  List<ColorPickerModel> deepOrange() {
    List<ColorPickerModel> _colors;
    _colors = List.generate(
        50,
        (index) => ColorPickerModel(
              index: (index - 49).abs(),
              color: Color.fromRGBO(255, 87, 34 + index, 1),
            ));
    _colors = _colors.reversed.toList();
    _colors.addAll([
      ...List.generate(
          50,
          (index) => ColorPickerModel(
                index: 50 + index,
                color: Color.fromRGBO(255, 87 - index, 34, 1),
              ))
    ]);
    return _colors;
  }

  List<ColorPickerModel> pink() {
    List<ColorPickerModel> _colors;
    _colors = List.generate(
        50,
        (index) => ColorPickerModel(
              index: (index - 49).abs(),
              color: Color.fromRGBO(233, 30 + index, 99 + index, 1),
            ));
    _colors = _colors.reversed.toList();
    _colors.addAll([
      ...List.generate(
          50,
          (index) => ColorPickerModel(
                index: 50 + index,
                color: Color.fromRGBO(233 - index, 30, 90, 1),
              ))
    ]);
    return _colors;
  }

  List<ColorPickerModel> orange() {
    List<ColorPickerModel> _colors;
    _colors = List.generate(
        50,
        (index) => ColorPickerModel(
              index: (index - 49).abs(),
              color: Color.fromRGBO(255, 152, 0 + (index * 2), 1),
            ));
    _colors = _colors.reversed.toList();
    _colors.addAll([
      ...List.generate(
          50,
          (index) => ColorPickerModel(
                index: 50 + index,
                color: Color.fromRGBO(255, 152 - index, 0, 1),
              ))
    ]);
    return _colors;
  }

  List<ColorPickerModel> red() {
    List<ColorPickerModel> _colors;
    _colors = List.generate(
        50,
        (index) => ColorPickerModel(
              index: (index - 49).abs(),
              color: Color.fromRGBO(244, 67 + index, 54 + index, 1),
            ));
    _colors = _colors.reversed.toList();
    _colors.addAll([
      ...List.generate(
          50,
          (index) => ColorPickerModel(
                index: 50 + index,
                color: Color.fromRGBO(244, 67 - index, 54 - index, 1),
              ))
    ]);
    return _colors;
  }
}
