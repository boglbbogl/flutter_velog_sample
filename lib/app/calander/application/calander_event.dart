import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CalanderEvent extends Equatable {}

class CalanderStartEvent extends CalanderEvent {
  final DateTime? datTime;

  CalanderStartEvent({
    this.datTime,
  });
  @override
  List<Object?> get props => [];
}

class CalanderChangeEvent extends CalanderEvent {
  final bool isNext;
  CalanderChangeEvent({required this.isNext});
  @override
  List<Object?> get props => [];
}

class CalanderUpdateBlurEvent extends CalanderEvent {
  final DragUpdateDetails updateDetails;

  CalanderUpdateBlurEvent({required this.updateDetails});
  @override
  List<Object?> get props => [];
}

class CalanderEndBlurEvent extends CalanderEvent {
  final DragEndDetails endDetails;

  CalanderEndBlurEvent({required this.endDetails});

  @override
  List<Object?> get props => [];
}
