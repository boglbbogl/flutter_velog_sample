import 'package:equatable/equatable.dart';

abstract class TextListenerEvent extends Equatable {}

class TextAddListenerEvent extends TextListenerEvent {
  final String text;
  TextAddListenerEvent(this.text);
  @override
  List<Object?> get props => [];
}
