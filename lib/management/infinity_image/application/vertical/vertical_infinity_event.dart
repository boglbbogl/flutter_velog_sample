import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class VerticalInfinityEvent extends Equatable {}

class VerticalInitImagesEvent extends VerticalInfinityEvent {
  @override
  List<Object?> get props => [];
}

class VerticalMoreImageEvent extends VerticalInfinityEvent {
  final ScrollUpdateNotification notification;

  VerticalMoreImageEvent(this.notification);
  @override
  List<Object?> get props => [notification];
}
