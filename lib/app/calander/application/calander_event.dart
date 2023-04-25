import 'package:equatable/equatable.dart';
import 'package:flutter_velog_sample/app/calander/model/calander_model.dart';

abstract class CalanderEvent extends Equatable {}

class TestEvent extends CalanderEvent {
  final TestModel test;

  TestEvent({required this.test});
  @override
  List<Object?> get props => [];
}
