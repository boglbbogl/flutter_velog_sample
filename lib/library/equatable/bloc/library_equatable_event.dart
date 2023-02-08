import 'package:equatable/equatable.dart';

abstract class LibraryEquatableEvent extends Equatable {}

class IncrementEquatableEvent extends LibraryEquatableEvent {
  @override
  List<Object?> get props => [];
}

class ReturnEquatableEvent extends LibraryEquatableEvent {
  @override
  List<Object?> get props => [];
}
