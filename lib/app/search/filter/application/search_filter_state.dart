import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class SearchFilterState extends Equatable {
  final Timer? timer;
  final String query;
  final List<List<String>>? strings;

  const SearchFilterState({
    this.timer,
    this.query = "",
    this.strings,
  });
}

class SearchFilterInitState extends SearchFilterState {
  @override
  List<Object?> get props => [];
}

class SearchFilterSearchingState extends SearchFilterState {
  const SearchFilterSearchingState({super.timer, super.strings, super.query});
  @override
  List<Object?> get props => [timer, query];
}

class SearchFilterSearchedState extends SearchFilterState {
  const SearchFilterSearchedState({super.strings, super.query});
  @override
  List<Object?> get props => [query];
}
