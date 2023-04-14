import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TextListenerEvent extends Equatable {}

class TextAddListenerEvent extends TextListenerEvent {
  final TextEditingController controller;
  TextAddListenerEvent(this.controller);
  @override
  List<Object?> get props => [controller];
}
