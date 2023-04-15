import 'package:equatable/equatable.dart';

abstract class TextListenerState extends Equatable {
  final String message;
  const TextListenerState({this.message = ""});
}

class TextListenerInitState extends TextListenerState {
  @override
  List<Object?> get props => [];
}

class TextListenerInputState extends TextListenerState {
  @override
  List<Object?> get props => [];
}

class TextListenerSpecialErrorState extends TextListenerState {
  const TextListenerSpecialErrorState({super.message});
  @override
  List<Object?> get props => [];
}

class TextListenerUpperErrorState extends TextListenerState {
  const TextListenerUpperErrorState({super.message});
  @override
  List<Object?> get props => [];
}

class TextListenerNumberErrorState extends TextListenerState {
  const TextListenerNumberErrorState({super.message});
  @override
  List<Object?> get props => [];
}
