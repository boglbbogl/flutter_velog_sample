import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class SearchFilterState extends Equatable {
  final Timer? timer;
  final String query;
  final List<List<String>>? strings;
  final List<List<Map<String, int>>>? filterings;

  const SearchFilterState({
    this.timer,
    this.query = "",
    this.strings,
    this.filterings,
  });
}

class SearchFilterInitState extends SearchFilterState {
  @override
  List<Object?> get props => [];
}

class SearchFilterSearchingState extends SearchFilterState {
  const SearchFilterSearchingState(
      {super.timer, super.strings, super.query, super.filterings});
  @override
  List<Object?> get props => [timer, query];
}

class SearchFilterSearchedState extends SearchFilterState {
  const SearchFilterSearchedState(
      {super.strings, super.query, super.filterings});
  @override
  List<Object?> get props => [query];
}
