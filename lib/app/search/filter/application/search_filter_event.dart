import 'package:equatable/equatable.dart';

abstract class SearchFilterEvent extends Equatable {}

class SearchFilterSearchingEvent extends SearchFilterEvent {
  @override
  List<Object?> get props => [];
}
