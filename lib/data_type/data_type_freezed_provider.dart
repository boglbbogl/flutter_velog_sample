import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/data_type/freezed_sample_data.dart';

class DataTypeFreezedProvider extends ChangeNotifier {
  List<FreezedSampleData> data = [];

  void started() {
    data = List.generate(5, (index) => FreezedSampleData.empty());
  }
}
