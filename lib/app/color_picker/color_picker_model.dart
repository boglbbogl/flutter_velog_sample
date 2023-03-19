import 'package:flutter/material.dart';

class ColorPickerModel {
  final int index;
  final Color color;
  const ColorPickerModel({
    required this.index,
    required this.color,
  });

  ColorPickerModel copyWith({
    required int? index,
    required Color? color,
  }) {
    return ColorPickerModel(
      index: index ?? this.index,
      color: color ?? this.color,
    );
  }
}

enum ColorType {
  red([244, 67, 54]),
  pink([233, 30, 99]),
  deepOrange([255, 87, 34]),
  orange([255, 152, 0]),
  amber([255, 193, 7]),
  yellow([255, 235, 59]),
  lightGreen([139, 195, 74]),
  green([76, 175, 80]),
  teal([0, 150, 136]),
  cyan([0, 188, 212]),
  lightBlue([3, 169, 244]),
  blue([33, 150, 243]),
  navy([33, 64, 243]),
  purple([156, 39, 176]),
  deepPurple([103, 58, 183]),
  white([206, 206, 206]),
  grey([100, 100, 100]),
  black([49, 49, 49]);

  final List<int> rgb;
  const ColorType(this.rgb);
}
