import 'package:flutter/material.dart';

class DataTypeFreezedProvider extends ChangeNotifier {
  List<String> data = [];
  void started() {
    // data = List.generate(5, (index) => FreezedSampleData.empty());
  }
}
