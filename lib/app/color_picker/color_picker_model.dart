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
