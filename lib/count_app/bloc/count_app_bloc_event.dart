part of 'count_app_bloc_bloc.dart';

@immutable
abstract class CountAppBlocEvent extends Equatable {
  const CountAppBlocEvent();
  @override
  List<Object> get props => [];
}

class CountAppBlocIncrement extends CountAppBlocEvent {}

class CountAppBlocDecrement extends CountAppBlocEvent {}

class CountAppBlocReset extends CountAppBlocEvent {}

class CountAppBlocSelect extends CountAppBlocEvent {
  final int selectCount;

  const CountAppBlocSelect(this.selectCount);
  @override
  List<Object> get props => [selectCount];
}
