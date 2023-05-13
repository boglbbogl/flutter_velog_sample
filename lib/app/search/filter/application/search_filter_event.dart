import 'package:equatable/equatable.dart';

abstract class SearchFilterEvent extends Equatable {}

class SearchFilterSearchingEvent extends SearchFilterEvent {
  final String query;
  SearchFilterSearchingEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class SearchFilterTimerEvent extends SearchFilterEvent {
  final String query;
  SearchFilterTimerEvent({required this.query});
  @override
  List<Object?> get props => [query];
}
