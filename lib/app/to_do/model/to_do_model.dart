import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String uid;
  final String title;
  final String description;
  final int tag;
  final Timestamp dateTime;
  final bool isSuccess;

  const TodoModel({
    required this.uid,
    required this.title,
    required this.description,
    required this.tag,
    required this.dateTime,
    required this.isSuccess,
  });

  TodoModel copyWith({
    final String? uid,
    final String? title,
    final String? description,
    final int? tag,
    final Timestamp? dateTime,
    final bool? isSuccess,
  }) {
    return TodoModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      tag: tag ?? this.tag,
      dateTime: dateTime ?? this.dateTime,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      uid: json["uid"],
      title: json["title"],
      description: json["description"],
      tag: json["tag"],
      dateTime: json["dateTime"],
      isSuccess: json["isSuccess"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "title": title,
      "description": description,
      "tag": tag,
      "dateTime": dateTime,
      "isSuccess": isSuccess,
    };
  }
}
