import 'package:equatable/equatable.dart';

abstract class SearchFilterState extends Equatable {}

class SearchFilterInitState extends SearchFilterState {
  @override
  List<Object?> get props => [];
}
