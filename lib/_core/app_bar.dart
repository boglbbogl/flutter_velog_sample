import 'package:flutter/material.dart';

AppBar appBar({
  required String title,
}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(fontSize: 18),
    ),
  );
}
