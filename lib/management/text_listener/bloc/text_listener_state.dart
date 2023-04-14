import 'package:equatable/equatable.dart';

abstract class TextListenerState extends Equatable {
  final String text;
  const TextListenerState({this.text = ""});
}

class TextListenerInitState extends TextListenerState {
  @override
  List<Object?> get props => [];
}

class TextListenerSpecialErrorState extends TextListenerState {
  @override
  List<Object?> get props => [];
}

class TextListenerUpperErrorState extends TextListenerState {
  const TextListenerUpperErrorState({super.text});
  @override
  List<Object?> get props => [];
}

class TextListenerNumberErrorState extends TextListenerState {
  @override
  List<Object?> get props => [];
}
