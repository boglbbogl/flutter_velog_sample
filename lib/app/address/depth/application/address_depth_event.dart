import 'package:equatable/equatable.dart';

abstract class AddressDepthEvent extends Equatable {}

class AddressDepthMajorEvent extends AddressDepthEvent {
  @override
  List<Object?> get props => [];
}

class AddressDepthMiddlevent extends AddressDepthEvent {
  @override
  List<Object?> get props => [];
}
