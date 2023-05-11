import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class SearchFilterState extends Equatable {
  final Timer? timer;

  const SearchFilterState({
    this.timer,
  });
}

class SearchFilterInitState extends SearchFilterState {
  @override
  List<Object?> get props => [];
}

class SearchFilterSearchingState extends SearchFilterState {
  const SearchFilterSearchingState({super.timer});
  @override
  List<Object?> get props => [timer];
}
