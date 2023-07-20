import 'package:cloud_firestore/cloud_firestore.dart';

class TimeLineModel {
  final Timestamp time;
  final String type;
  final String content;

  TimeLineModel({
    required this.time,
    required this.type,
    required this.content,
  });

  factory TimeLineModel.fromJson(Map<String, dynamic> json) {
    return TimeLineModel(
      time: json["time"],
      type: json["type"],
      content: json["content"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "time": time,
      "type": type,
      "content": content,
    };
  }

  @override
  String toString() => toJson().toString();
}
