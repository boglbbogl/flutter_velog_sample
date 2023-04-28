import 'package:equatable/equatable.dart';

abstract class AddressDepthEvent extends Equatable {}

class AddressDepthMajorEvent extends AddressDepthEvent {
  @override
  List<Object?> get props => [];
}

class AddressDepthMiddleEvent extends AddressDepthEvent {
  final String code;

  AddressDepthMiddleEvent({required this.code});
  @override
  List<Object?> get props => [code];
}

class AddressDepthMinorEvent extends AddressDepthEvent {
  final String code;

  AddressDepthMinorEvent({required this.code});
  @override
  List<Object?> get props => [code];
}
