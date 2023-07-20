import 'package:cloud_firestore/cloud_firestore.dart';

class TimeLineModel {
  final Timestamp time;
  final String type;
  final String content;
  final int interval;
  final bool isBinding;

  TimeLineModel({
    required this.time,
    required this.type,
    required this.content,
    this.interval = 0,
    this.isBinding = false,
  });

  TimeLineModel copyWith({
    final Timestamp? time,
    final String? type,
    final String? content,
    final int? interval,
    final bool? isBinding,
  }) {
    return TimeLineModel(
      time: time ?? this.time,
      type: type ?? this.type,
      content: content ?? this.content,
      interval: interval ?? this.interval,
      isBinding: isBinding ?? this.isBinding,
    );
  }

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
  String toString() =>
      "time: $time, type: $type, content: $content, interval: $interval";
}
