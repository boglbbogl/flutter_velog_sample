import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_velog_sample/app/time_line/model/time_line_model.dart';

class TimeLineRepository {
  static final TimeLineRepository instance = TimeLineRepository._internal();
  factory TimeLineRepository() => instance;
  TimeLineRepository._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TimeLineModel>?> getAllTimeLine() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("time_line")
          .orderBy("time", descending: true)
          .get();
      List<TimeLineModel> list = snapshot.docs
          .map((e) => TimeLineModel.fromJson(e.data()! as Map<String, dynamic>))
          .toList();
      return list;
    } on FirebaseException catch (_) {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<TimeLineModel>?> getTimeLine({
    DateTime? date,
  }) async {
    try {
      DateTime _date = date ?? DateTime.now();
      QuerySnapshot snapshot = await _firestore
          .collection("time_line")
          .where(
            "time",
            isGreaterThan: DateTime(_date.year, _date.month, _date.day),
            isLessThan: DateTime(_date.year, _date.month, _date.day)
                .subtract(const Duration(days: -1)),
          )
          .orderBy("time", descending: true)
          .get();
      List<TimeLineModel> list = snapshot.docs
          .map((e) => TimeLineModel.fromJson(e.data()! as Map<String, dynamic>))
          .toList();
      return list;
    } on FirebaseException catch (_) {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<TimeLineModel?> setTimeLine(TimeLineModel model) async {
    try {
      await _firestore.collection("time_line").doc().set(model.toJson());
      return model;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }
}
