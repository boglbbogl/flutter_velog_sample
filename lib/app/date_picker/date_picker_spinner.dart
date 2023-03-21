import 'dart:ui';

import 'package:flutter/material.dart';

void datePickerSpinner(BuildContext context) {
  showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          width: MediaQueryData.fromWindow(window).size.width,
          color: Colors.amber,
        );
      });
}
