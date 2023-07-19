import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_velog_sample/app/time_line/model/time_line_model.dart';

class TimeLineRepository {
  static final TimeLineRepository instance = TimeLineRepository._internal();
  factory TimeLineRepository() => instance;
  TimeLineRepository._internal();

  Future<void> setTimeLine(TimeLineModel model) async {
    try {} on FirebaseException catch (e) {
      print(e);
    }
  }
}
